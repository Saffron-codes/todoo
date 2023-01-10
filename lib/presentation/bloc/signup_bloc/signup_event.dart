part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends SignupEvent {
  final String email;
  final String username;
  final String password;

  SignInButtonPressed(this.email, this.username, this.password);

  @override
  List<Object> get props => [email, username, password];
}
