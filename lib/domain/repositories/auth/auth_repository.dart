import 'package:dartz/dartz.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/domain/entities/user/user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, UserEntity>> signup(
    String email,
    String username,
    String password,
  );

  Future<Either<AuthFailure, UserEntity>> login(
    String email,
    String password,
  );

  Future<Either<AuthFailure, void>> logout();
}
