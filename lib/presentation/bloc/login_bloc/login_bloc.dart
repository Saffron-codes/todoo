import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/auth/login_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser login;
  LoginBloc({required this.login})
      : super(LoginInitial()) {
    on<LoginInButtonPressed>((event, emit) async {
      emit(LoginLoading());
      LoginParams loginParams =
          LoginParams(email: event.email, password: event.password);
      final failureOrUser = await login(loginParams);
      final result = failureOrUser.fold(
        (failure) => LoginFailure(message: "Some Error Occured"),
        (user) => LoginSuccess(),
      );
      emit(result);
    });
  }
}
