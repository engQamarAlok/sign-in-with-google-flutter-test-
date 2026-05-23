import 'package:dartz/dartz.dart';
import 'package:tasks_management_app2/features/login_with_google/domain/entities/user_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../repositories/login_repository.dart';

class GetLogin {
  final LoginRepository repository;

  GetLogin({required this.repository});

  Future<Either<Failure, UserEntity>> call({required LoginParams params}) {
    return repository.loginWithGoogle();
  }
}
