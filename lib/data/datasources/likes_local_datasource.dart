abstract class LikesLocalDataSource {
  Future<int> getLikesCount();
  Future<void> saveLikesCount(int count);
  Future<void> clearLikes();
}