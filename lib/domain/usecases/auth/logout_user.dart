import 'package:dartz/dartz.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';
import '../../repositories/auth/auth_repository.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUser({required this.authRepository});
  @override
  Future<Either<AuthFailure, void>> call(params)async {
     return  await authRepository.logout();
  }
}