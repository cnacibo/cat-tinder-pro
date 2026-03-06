import '../../domain/repositories/likes_repository.dart';
import '../datasources/likes_local_datasource.dart';

class LikesRepositoryImpl implements LikesRepository {
  final LikesLocalDataSource _localDataSource;

  LikesRepositoryImpl({required LikesLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<int> getLikesCount() => _localDataSource.getLikesCount();

  @override
  Future<void> incrementLikes() async {
    final current = await _localDataSource.getLikesCount();
    await _localDataSource.saveLikesCount(current + 1);
  }

  @override
  Future<void> resetLikes() => _localDataSource.clearLikes();
}