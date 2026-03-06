import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import '../../core/injection.dart' as di;
import '../../domain/repositories/auth_repository.dart';
import 'auth_screen.dart';
import 'main_tab_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }
  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    Widget nextScreen;
    if (!onboardingCompleted) {
      nextScreen = const OnboardingScreen();
    } else {
      final authRepo = di.getIt<AuthRepository>();
      final loggedIn = await authRepo.isLoggedIn();
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