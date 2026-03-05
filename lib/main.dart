import 'package:flutter/material.dart';
import 'presentation/screens/main_tab_screen.dart';
import 'data/sources/cat_api_service.dart';
import 'core/injection.dart' as di;
import 'domain/repositories/auth_repository.dart';
import 'presentation/auth/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await CatApiService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CatTinder());
}

class CatTinder extends StatelessWidget {
  const CatTinder({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color(0xFF283618),    
          onPrimary: Colors.white,
          secondary: const Color(0xFFDDA15E), 
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: const Color(0xFFFFFFFF),
          onSurface: const Color(0xFF283618),
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Color(0xFF283618),
          elevation: 2,
          centerTitle: true,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Color(0xFF283618).withOpacity(0.3),
          indicatorColor: Color(0xFF283618).withOpacity(0.5),
          surfaceTintColor: Color(0xFF283618), 
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
        ),
      );

    return MaterialApp(
      title: 'Cat Tinder',
      theme: myTheme,
      home: const InitialScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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

