// class AuthException implements Exception{}
class DatabaseException implements Exception {}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}
