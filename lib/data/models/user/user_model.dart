import 'package:todolist_supabase/domain/entities/user/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

class UserModel extends UserEntity {
  final String uid;
  final String email;
  final String username;
  UserModel({
    required this.uid,
    required this.email,
    required this.username,
  }) : super(
          uid: uid,
          email: email,
          username: username,
        );
    factory UserModel.convertFromSupabaseUser(s.User user) {
    return UserModel(
      uid: user.id,
      email: user.email.toString(),
      username: user.userMetadata!['username'],
    );
  }
}
