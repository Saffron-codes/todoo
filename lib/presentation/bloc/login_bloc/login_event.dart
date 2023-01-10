part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginInButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}