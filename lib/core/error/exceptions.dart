// ошибки связанные с сетью
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);
}

// исключения при отсутствии интернета
class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'No internet connection']);
}

// исключение при ошибках кэширования и локального хранилища
class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache error']);
}

// исключение при неверных данных аутентификации
class AuthException implements Exception {
  final String message;
  AuthException([this.message = 'Authentication failed']);
}