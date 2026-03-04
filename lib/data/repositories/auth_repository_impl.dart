import './auth_repository.dart';
import '../sources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> signUp(String email, String password) async {
    try {
      await localDataSource.saveUser(email, password);
      await localDataSource.setLoggedIn(true);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      final valid = await localDataSource.validateUser(email, password);
      if (valid) {
        await localDataSource.setLoggedIn(true);
      }
      return valid;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isLoggedIn() => localDataSource.isLoggedIn();

  @override
  Future<void> signOut() => localDataSource.clear();
}