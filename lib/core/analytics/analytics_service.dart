import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logSignUp(String email) async {
    await _analytics.logSignUp(signUpMethod: 'email');
    await _analytics.setUserProperty(name: 'email', value: email);
  }

  static Future<void> logSignIn(String email) async {
    await _analytics.logLogin(loginMethod: 'email');
  }

  static Future<void> logSignUpFailed(String email, String reason) async {
    await _analytics.logEvent(
      name: 'sign_up_failed',
      parameters: {'email': email, 'reason': reason},
    );
  }

  static Future<void> logSignInFailed(String email, String reason) async {
    await _analytics.logEvent(
      name: 'sign_in_failed',
      parameters: {'email': email, 'reason': reason},
    );
  }

  static Future<void> logLogout() async {
    await _analytics.logEvent(name: 'logout');
  }
  
}