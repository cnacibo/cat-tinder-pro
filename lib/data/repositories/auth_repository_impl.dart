import './auth_repository.dart';
import '../sources/auth_local_datasource.dart';
import '../sources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
    });

  @override
  Future<bool> signUp(String email, String password) async {
    try {
      final uid = await remoteDataSource.signUp(email, password);
      // await localDataSource.saveUser(email, password);
      await localDataSource.setLoggedIn(true);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      final uid = await remoteDataSource.signIn(email, password);
      // final valid = await localDataSource.validateUser(email, password);
      // if (valid) {
      //   await localDataSource.setLoggedIn(true);
      // }
      await localDataSource.setLoggedIn(true);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isLoggedIn() => localDataSource.isLoggedIn();

  @override
  Future<bool> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}