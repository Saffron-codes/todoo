import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/entities/user/user.dart';
import 'package:todolist_supabase/domain/repositories/auth/auth_repository.dart';

class SignupUser implements UseCase<UserEntity, SignupParams> {
  final AuthRepository authRepository;

  SignupUser({required this.authRepository});
  @override
  Future<Either<AuthFailure, UserEntity>> call(params) async {
    return await authRepository.signup(
      params.email,
      params.username,
      params.password,
    );
  }
}

class SignupParams extends Equatable {
  String email;
  String username;
  String password;
  SignupParams({
    required this.email,
    required this.username,
    required this.password,
  });
  @override
  List<Object> get props => [email, username, password];
}
