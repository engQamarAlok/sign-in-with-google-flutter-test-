import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tasks_management_app2/core/connection/network_info.dart';
import 'package:tasks_management_app2/core/databases/api/api_consumer.dart';
import 'package:tasks_management_app2/core/databases/api/dio_consumer.dart';
import 'package:tasks_management_app2/core/databases/cache/cache_helper.dart';
import 'package:tasks_management_app2/features/login_with_google/data/datasources/login_local_data_source.dart';
import 'package:tasks_management_app2/features/login_with_google/data/datasources/login_remote_data_source.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSource(cache: getIt(), flutterSecureStorage: getIt()),
  );
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt()));

  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton(() => FlutterSecureStorage());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );
}
