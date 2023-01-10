part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized  extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}
class DismissDialog extends AuthState {}
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class Loading extends AuthState {}
