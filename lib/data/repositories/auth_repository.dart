abstract class AuthRepository {
  Future<bool> signUp(String email, String password);
  Future<bool> signIn(String email, String password);
  Future<bool> isLoggedIn();
  Future<bool> signOut();
}