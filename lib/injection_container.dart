import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/services/authentication_service.dart';
import 'package:todolist_supabase/core/services/dialog_service.dart';
import 'package:todolist_supabase/core/services/snackbar_service.dart';
import 'package:todolist_supabase/data/data_sources/auth/auth_data_source.dart';
import 'package:todolist_supabase/data/data_sources/todo/todo_data_source.dart';
import 'package:todolist_supabase/data/repositories/auth/auth_repository_impl.dart';
import 'package:todolist_supabase/data/repositories/todo/todo_repository_impl.dart';
import 'package:todolist_supabase/domain/repositories/auth/auth_repository.dart';
import 'package:todolist_supabase/domain/repositories/todo/todo_repository.dart';
import 'package:todolist_supabase/domain/usecases/auth/login_user.dart';
import 'package:todolist_supabase/domain/usecases/todo/check_todo.dart';
import 'package:todolist_supabase/domain/usecases/todo/delete_todo.dart';
import 'package:todolist_supabase/domain/usecases/todo/get_all_todo.dart';
import 'package:todolist_supabase/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/internet_bloc/internet_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/todo_bloc/todo_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/todo_crud_bloc/todo_crud_bloc.dart';
import 'package:todolist_supabase/presentation/bloc/todo_form/todo_form_bloc.dart';
import 'package:todolist_supabase/domain/usecases/todo/create_todo.dart';

import 'domain/usecases/auth/logout_user.dart';
import 'domain/usecases/auth/signup_user.dart';


GetIt sl = GetIt.instance;
Supabase supabase = Supabase.instance;


Future<void> init() async {
  // Bloc
  sl.registerFactory(() => LoginBloc(login: sl()));
  sl.registerFactory(() => SignupBloc(signup: sl()));
  sl.registerFactory(() => TodoBloc(getAllTodos: sl()));
  sl.registerFactory(() => InternetBloc(connectivity: sl()));
  sl.registerFactory(() => TodoFormBloc(createTodo: sl()));
  sl.registerFactory(() => TodoCrudBloc(deleteTodo: sl(), checkTodo: sl()));

  // Usecases 
  sl.registerLazySingleton(() => SignupUser(authRepository: sl()));
  sl.registerLazySingleton(() => LoginUser(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUser(authRepository: sl()));
  sl.registerLazySingleton(() => GetAllTodos(todorepository: sl()));
  sl.registerLazySingleton(() => CreateTodo(todorepository: sl()));
  sl.registerLazySingleton(() => DeleteTodo(todoRepository: sl()));
  sl.registerLazySingleton(() => CheckTodo(todorepository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authDataSource: sl()));
  sl.registerLazySingleton<TodoRepository>(() => TodosRepositoryImpl(todoRemoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(client: sl()));
  sl.registerLazySingleton<TodoRemoteDataSource>(() => TodoRemoteDataSourceImpl(client: sl()));

  // External 
  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  
  // getIt.registerSingleton<AuthService>(AuthService());
  // getIt.registerSingleton<SnackbarService>(SnackbarService());
  // getIt.registerSingleton<DialogService>(DialogService());
}