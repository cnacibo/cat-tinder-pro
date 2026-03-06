import '../repositories/onboarding_repository.dart';

class CheckOnboardingUseCase {
  final OnboardingRepository repository;
  CheckOnboardingUseCase(this.repository);
  Future<bool> execute() => repository.isOnboardingCompleted();
}