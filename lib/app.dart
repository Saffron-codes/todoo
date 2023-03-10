import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_supabase/injection_container.dart';
import 'package:todolist_supabase/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/internet_bloc/internet_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/todo_crud_bloc/todo_crud_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/todo_form/todo_form_bloc.dart';
import 'domain/usecases/auth/logout_user.dart';
import 'presentation/pages/app_views.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>(),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => sl<SignupBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
              logoutUser: sl<LogoutUser>(),
              loginBloc: BlocProvider.of<LoginBloc>(context),
              signupBloc: BlocProvider.of<SignupBloc>(context))
            ..add(
              AppStarted(),
            ),
        ),
        BlocProvider<InternetBloc>(
          create: (context) => InternetBloc(
            connectivity: sl<Connectivity>(),
          )..add(ListenInternet()),
        ),
        BlocProvider<TodoFormBloc>(
          create: (context) => sl<TodoFormBloc>(),
        ),
         BlocProvider<TodoCrudBloc>(
          create: (context) => sl<TodoCrudBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: Colors.purple.shade900,
          ),
        ),
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)),
        initialRoute: '/',
        routes: {
          '/': (context) => DeceiderView(),
          '/login': (context) => LoginView(),
          '/signup': (context) => SignupView(),
          '/todos': (context) => AllTodosView(),
          '/create': (context) => CreateTodoPage()
        },
      ),
    );
  }
}
