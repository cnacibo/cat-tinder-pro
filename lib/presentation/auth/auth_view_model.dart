import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    final result = await _authRepository.signIn(email, password);
    _setLoading(false);
    return result;
  }

  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    final result = await _authRepository.signUp(email, password);
    _setLoading(false);
    return result;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}