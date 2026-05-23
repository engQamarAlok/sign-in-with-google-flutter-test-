import 'package:tasks_management_app2/core/databases/api/end_points.dart';
import 'package:tasks_management_app2/features/login_with_google/data/models/user_model.dart';

import '../../domain/entities/login_entitiy.dart';

class LoginModel extends LoginEntity {
  final String accessToken;
  final String refreshToken;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required super.userData,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json[ApiKey.accessToken],
      refreshToken: json[ApiKey.refreshToken],
      userData: UserModel.fromJson(json[ApiKey.user]),
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.accessToken: accessToken, ApiKey.refreshToken: refreshToken};
  }
}
