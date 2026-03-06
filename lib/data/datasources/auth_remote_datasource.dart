abstract class AuthRemoteDataSource {
  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);
  Future<void> signOut();
  Future<String?> getCurrentUserId();
  Future<bool> isLoggedIn();
}