import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<bool> execute(String email, String password) {
    return _repository.signUp(email, password);
  }
}