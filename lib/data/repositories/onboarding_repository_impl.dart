import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final SharedPreferences sharedPreferences;
  static const String _key = 'onboarding_completed';

  OnboardingRepositoryImpl({required this.sharedPreferences});

  @override
  Future<bool> isOnboardingCompleted() async => sharedPreferences.getBool(_key) ?? false;

  @override
  Future<void> setOnboardingCompleted() async => sharedPreferences.setBool(_key, true);
}