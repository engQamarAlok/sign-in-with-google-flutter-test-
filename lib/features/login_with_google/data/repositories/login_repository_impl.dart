import 'package:dartz/dartz.dart';
import 'package:tasks_management_app2/core/connection/network_info.dart';
import 'package:tasks_management_app2/core/errors/exceptions.dart';
import 'package:tasks_management_app2/core/errors/failure.dart';
import 'dart:developer';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_source.dart';
import '../datasources/login_remote_data_source.dart';

import '../../domain/entities/user_entity.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    log("💼 [Repository] بدء تنسيق عملية تسجيل الدخول...");

    try {
      final userCredential = await remoteDataSource.signInWithGoogle();

      if (userCredential == null) {
        return Left(Failure(errMessage: "تم إلغاء تسجيل الدخول"));
      }

      final String? idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        return Left(Failure(errMessage: "فشل جلب توكن التوثيق"));
      }

      log(
        "🌐 [Repository] جاري إرسال التوكن إلى سيرفر Django وحفظ البيانات محلياً...",
      );

    /*  await localDataSource.saveLoginData(
        accessToken: "الـ Access Token القادم من Django",
        refreshToken: "الـ Refresh Token القادم من Django",
      );*/

      final userEntity = UserEntity(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? "",
        photoUrl: userCredential.user!.photoURL ?? "",
      );

      return Right(userEntity);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorModel.errorMessage));
    }
  }
}
