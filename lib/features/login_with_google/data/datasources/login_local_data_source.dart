import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasks_management_app2/core/errors/exceptions.dart';
import 'package:tasks_management_app2/features/login_with_google/data/models/user_model.dart';

import '../../../../core/databases/cache/cache_helper.dart';
import '../models/login_model.dart';

class LoginLocalDataSource {
  final FlutterSecureStorage flutterSecureStorage;
  final CacheHelper cache;
  static const String _accessTokenKey = "ACCESS_TOKEN";
  static const String _refreshTokenKey = "REFRESH_TOKEN";
  static const String _userDataKey = "USER_DATA";

  LoginLocalDataSource({
    required this.cache,
    required this.flutterSecureStorage,
  });

  Future<void> saveLoginData(LoginModel? loginModel) async {
    if (loginModel != null) {
      await flutterSecureStorage.write(
        key: _accessTokenKey,
        value: loginModel.accessToken,
      );
      await flutterSecureStorage.write(
        key: _refreshTokenKey,
        value: loginModel.refreshToken,
      );
      await cache.saveData(
        key: _userDataKey,
        value: json.encode(
          loginModel.userData.toJson(),
        ), //ها السطر بيحولو لماب بعدين بيحطا ك سترينغ يعني بين كوتيشن
      );
    } else {
      throw CacheException(errorMessage: "failure saving data");
    }
  }

  Future<String?> getSavedAccessToken() async {
    return flutterSecureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getSavedRefreshToken() async {
    return flutterSecureStorage.read(key: _refreshTokenKey);
  }

  Future<UserModel?> getSavedUserData() async {
    final stringJson = cache.getDataString(key: _userDataKey);
    if (stringJson != null) {
      return UserModel.fromJson(json.decode(stringJson));//ها السطر بيشيل الكوتيشن و بيرجعا من ماب إلى موديل
    } else {
      throw CacheException(errorMessage: "No cached user data found");
    }
  }
}
