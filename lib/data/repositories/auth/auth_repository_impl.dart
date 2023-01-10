import 'package:dartz/dartz.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/data/data_sources/auth/auth_data_source.dart';
import 'package:todolist_supabase/domain/repositories/auth/auth_repository.dart';
import '../../models/user/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<AuthFailure, UserModel>> login(
      String email, String password) async {
    try {
      return Right(
        await authDataSource.login(email, password),
      );
    } on AuthFailure {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<AuthFailure, void>> logout() async {
    try {
      return Right(
        await authDataSource.logout(),
      );
    } on AuthFailure {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signup(
      String email, String username, String password) async {
    try {
      return Right(
        await authDataSource.signup(email, username, password),
      );
    } on AuthFailure {
      return Left(AuthFailure());
    }
  }
}
