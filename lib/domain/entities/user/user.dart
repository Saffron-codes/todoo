import 'package:supabase_flutter/supabase_flutter.dart' as s;

class UserEntity {
  final String uid;
  final String email;
  final String username;
  UserEntity({
    required this.uid,
    required this.email,
    required this.username
  });

  factory UserEntity.convertFromSupabaseUser(s.User user) {
    return UserEntity(
      uid: user.id,
      email: user.email.toString(),
      username: user.userMetadata!['username'],
    );
  }
}
