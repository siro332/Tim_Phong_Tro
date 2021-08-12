class ServerException implements Exception {}

class CachedException implements Exception {}

class AuthException implements Exception {
  String message;

  AuthException({required this.message});
}
