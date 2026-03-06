import '../repositories/likes_repository.dart';

class ResetLikesUseCase {
  final LikesRepository _repository;
  ResetLikesUseCase(this._repository);
  Future<void> execute() => _repository.resetLikes();
}