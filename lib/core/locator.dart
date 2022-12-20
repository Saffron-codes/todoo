import 'package:get_it/get_it.dart';
import 'package:todolist_supabase/core/services/authentication_service.dart';
import 'package:todolist_supabase/core/services/dialog_service.dart';
import 'package:todolist_supabase/core/services/snackbar_service.dart';


GetIt getIt = GetIt.instance;

void setuplocator() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<SnackbarService>(SnackbarService());
  getIt.registerSingleton<DialogService>(DialogService());
}