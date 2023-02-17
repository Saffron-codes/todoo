import 'package:supabase_flutter/supabase_flutter.dart' as s;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/error/exceptions.dart' as exceptions;
import 'package:todolist_supabase/core/error/failures.dart';
import 'package:todolist_supabase/data/models/user/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> signup(String email, String name, String password);

  Future<UserModel> login(String email, String password);

  Future<void> logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  s.SupabaseClient client;
  AuthDataSourceImpl({required this.client});
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final authRes = await client.auth
          .signInWithPassword(email: email, password: password);
      return UserModel.convertFromSupabaseUser(authRes.user!);
    } on AuthException catch(e) {
      throw exceptions.AuthException(message: e.message);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await client.auth.signOut();
    } on s.AuthException catch(e) {
      throw exceptions.AuthException(message: e.message);
    }
  }

  @override
  Future<UserModel> signup(
      String email, String username, String password) async {
    try {
      final authRes = await client.auth.signUp(
          email: email, password: password, data: {'username': username});
      return UserModel.convertFromSupabaseUser(authRes.user!);
    } on AuthException catch(e) {
      throw exceptions.AuthException(message: e.message);
    }
  }
}
