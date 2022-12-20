import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/services/authentication_service.dart';
import 'package:todolist_supabase/core/services/dialog_service.dart';
import 'package:todolist_supabase/core/services/snackbar_service.dart';

class AuthViewModel extends ChangeNotifier {
  AuthService _authService = GetIt.I.get<AuthService>();
  SnackbarService _snackBarService = GetIt.I.get<SnackbarService>();
  DialogService _dialogService = GetIt.I.get<DialogService>();
  late User? _user;
  void login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      _dialogService.showLoadingDialog(context: context);
      final response =
          await _authService.login(email: email, password: password);
      _user = response.user;
      _dialogService.closeDialog(context: context);
      // Navigator.pushReplacementNamed(context, '/todos');
            Navigator.pushNamedAndRemoveUntil(context, '/todos', (route)=>false);

      _snackBarService.showSuccess(
          context: context, message: "Logged in Successfully 🎉");
      notifyListeners();
    } on AuthException catch (e) {
      _dialogService.closeDialog(context: context);
      _snackBarService.showError(context: context, message: e.message);
    } catch (e) {
      _dialogService.closeDialog(context: context);
      _snackBarService.showError(
          context: context, message: "Connect to Internet");
    }
  }

  void signup({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      _dialogService.showLoadingDialog(context: context);
      final response =
          await _authService.signup(context: context,username: username,email: email, password: password);
      _user = response.user;
      _dialogService.closeDialog(context: context);
      Navigator.pushNamedAndRemoveUntil(context, '/todos', (route)=>false);
      _snackBarService.showSuccess(
          context: context, message: "Signed up Successfully 🎉");
      notifyListeners();
    } on AuthException catch (e) {
      _dialogService.closeDialog(context: context);
      _snackBarService.showError(context: context, message: e.message);
    } catch (e) {
      _dialogService.closeDialog(context: context);
      _snackBarService.showError(
          context: context, message: "Connect to Internet");
    }
  }

  void logout({required BuildContext context}) async {
    try {
      await _authService.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);

    } catch (e) {
      _snackBarService.showError(
          context: context, message: "Error logging out");
    }
  }

  User? get user => _user;

  Stream<AuthState> get authState {
    return _authService.supabase.auth.onAuthStateChange;
  }

  Stream<User> get userStream {
    return _authService.supabase.auth.onAuthStateChange.map((authState) => authState.session!.user);

  }
}
