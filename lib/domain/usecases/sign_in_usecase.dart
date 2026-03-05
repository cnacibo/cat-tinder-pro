import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<bool> execute(String email, String password) {
    return _repository.signIn(email, password);
  }
}