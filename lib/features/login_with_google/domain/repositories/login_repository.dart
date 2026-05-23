import 'package:dartz/dartz.dart';
import 'package:tasks_management_app2/features/login_with_google/domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserEntity>> loginWithGoogle();
}
