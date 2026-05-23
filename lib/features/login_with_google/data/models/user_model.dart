import 'package:tasks_management_app2/core/databases/api/end_points.dart';
import 'package:tasks_management_app2/features/login_with_google/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.photoUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[ApiKey.uid],
      name: json[ApiKey.name],
      email: json[ApiKey.email],
      photoUrl: json[ApiKey.photoUrl],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      ApiKey.uid: uid,
      ApiKey.name: name,
      ApiKey.email: email,
      ApiKey.photoUrl: photoUrl,
    };
  }
}
