import 'package:shared_preferences/shared_preferences.dart';
import 'likes_local_datasource.dart';

class LikesLocalDataSourceImpl implements LikesLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _key = 'cat_tinder_likes';

  LikesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<int> getLikesCount() async {
    return sharedPreferences.getInt(_key) ?? 0;
  }

  @override
  Future<void> saveLikesCount(int count) async {
    await sharedPreferences.setInt(_key, count);
  }

  @override
  Future<void> clearLikes() async {
    await sharedPreferences.remove(_key);
  }
}