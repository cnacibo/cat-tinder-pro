import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> signUp(String email, String password) async {
    try {
      await remoteDataSource.signUp(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      await remoteDataSource.signIn(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isLoggedIn() => remoteDataSource.isLoggedIn();

  @override
  Future<bool> signOut() async {
    try {
      await remoteDataSource.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}