import '../repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository repository;
  CompleteOnboardingUseCase(this.repository);
  Future<void> execute() => repository.setOnboardingCompleted();
}