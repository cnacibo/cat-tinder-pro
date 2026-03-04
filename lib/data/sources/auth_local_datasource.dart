import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(String email, String password);
  Future<bool> validateUser(String email, String password);
  Future<void> setLoggedIn(bool value);
  Future<bool> isLoggedIn();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  static const _keyUserPrefix = 'user_';
  static const _keyLoggedIn = 'logged_in';

  @override
  Future<void> saveUser(String email, String password) async {
    await secureStorage.write(key: _keyUserPrefix + email, value: password);
  }

  @override
  Future<bool> validateUser(String email, String password) async {
    final stored = await secureStorage.read(key: _keyUserPrefix + email);
    return stored == password;
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    await secureStorage.write(key: _keyLoggedIn, value: value.toString());
  }

  @override
  Future<bool> isLoggedIn() async {
    final value = await secureStorage.read(key: _keyLoggedIn);
    return value == 'true';
  }

  @override
  Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}