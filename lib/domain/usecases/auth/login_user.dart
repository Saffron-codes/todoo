import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/user/user.dart';
import 'package:todolist_supabase/domain/repositories/auth/auth_repository.dart';

class LoginUser implements UseCase<UserEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUser({required this.authRepository});
  @override
  Future<Either<AuthFailure, UserEntity>> call(params)async {
     return  await authRepository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  String email;
  String password;
  LoginParams({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}
