import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/auth/signup_user.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUser signup;
  SignupBloc({required this.signup}) : super(SignupInitial()) {
    on<SignInButtonPressed>((event, emit) async {
      emit(SignupLoading());
      SignupParams signupParams =
          SignupParams(email: event.email,username: event.password, password: event.password);
      final failureOrUser = await signup(signupParams);
      final result = failureOrUser.fold(
        (failure) => SignupFailure(message: "Some Error Occured"),
        (user) => SignupSuccess(),
      );
      emit(result);
    });
  }
}
