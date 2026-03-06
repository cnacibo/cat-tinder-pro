import 'package:firebase_auth/firebase_auth.dart';
import '../../core/error/exceptions.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<String> signUp(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException('Registration failed: $e');
    }
  }

  @override
  Future<String> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw ServerException('Login failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<String?> getCurrentUserId() async {
    return firebaseAuth.currentUser?.uid;
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return AuthException('Email already registered');
      case 'invalid-email':
        return AuthException('Invalid email format');
      case 'weak-password':
        return AuthException('Password is too weak');
      case 'user-not-found':
      case 'wrong-password':
        return AuthException('Invalid email or password');
      default:
        return ServerException(e.message ?? 'Authentication error');
    }
  }

  Future<bool> isLoggedIn() async {
    return firebaseAuth.currentUser != null;
  }

}