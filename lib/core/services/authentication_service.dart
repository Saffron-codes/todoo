import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  Future<AuthResponse> signup({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
  }) async {
    return await supabase.auth
        .signUp(email: email, password: password, data: {'username': username});
  }

  Future<AuthResponse> login(
      {required String email, required String password}) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
