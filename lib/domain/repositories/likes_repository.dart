abstract class LikesRepository {
  Future<int> getLikesCount();
  Future<void> incrementLikes();
  Future<void> resetLikes();
}