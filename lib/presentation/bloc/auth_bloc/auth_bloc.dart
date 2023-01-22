import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/core/usecases/usecase.dart';
import 'package:todolist_supabase/domain/usecases/auth/logout_user.dart';
import 'package:todolist_supabase/injection_container.dart';
import 'package:todolist_supabase/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/signup_bloc/signup_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser logoutUser;
  final LoginBloc loginBloc;
  final SignupBloc signupBloc;
  late StreamSubscription loginSubscription;
  late StreamSubscription signupSubscription;
  AuthBloc({required this.logoutUser,required this.loginBloc,required this.signupBloc}) : super(Uninitialized()) {
    /// Listening to the login & signup bloc for navigation
    loginSubscription = loginBloc.stream.listen((state){
      if(state is LoginSuccess){
        emit(Authenticated());
      }
    });
    signupSubscription = signupBloc.stream.listen((state){
      if(state is SignupSuccess){
        emit(Authenticated());
      }
    });
    on<AppStarted>((event, emit) {
      final supabase = sl<SupabaseClient>();
      if (supabase.auth.currentUser != null) {
        supabase.auth.refreshSession();
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
    on<Loggedout>((event, emit)async{
      emit(Loading());
      final result = await logoutUser.call(NoParams());
      // final state = result.fold((l) => Unauthenticated(), (r) => Authenticated());
      if(result != AuthFailure){
        emit(DismissDialog());
        emit(Unauthenticated());
      }else{
        emit(AuthError(message: "Error Logging out"));
      }
      
    });
  }
  @override
  Future<void> close() {
    signupSubscription.cancel();
    loginSubscription.cancel();
    return super.close();
  }
}
