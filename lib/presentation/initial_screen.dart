import 'package:flutter/material.dart';
import '../../core/injection.dart'; 
import 'onboarding/onboarding_screen.dart';
import 'auth/auth_screen.dart';
import 'main_tab_screen.dart';
import '../domain/usecases/check_onboarding_usecase.dart';
import '../domain/usecases/is_logged_in_usecase.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late final CheckOnboardingUseCase _checkOnboarding;
  late final IsLoggedInUseCase _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkOnboarding = getIt<CheckOnboardingUseCase>();
    _isLoggedIn = getIt<IsLoggedInUseCase>();
    _checkAuthStatus();
  }
  Future<void> _checkAuthStatus() async {
    final onboardingCompleted = await _checkOnboarding.execute();

    Widget nextScreen;
    if (!onboardingCompleted) {
      nextScreen = const OnboardingScreen();
    } else {
      final loggedIn = await _isLoggedIn.execute();
      nextScreen = loggedIn ? const MainTabScreen() : const AuthScreen();
    }

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => nextScreen),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}