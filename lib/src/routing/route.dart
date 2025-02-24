import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iot_app/src/features/authentication/login/login_screen.dart';
import 'package:iot_app/src/features/authentication/signup/signup_screen.dart';
import 'package:iot_app/src/features/authentication/splash/splash_screen.dart';
import 'package:iot_app/src/features/authentication/welcom/welcom_screen.dart';
import 'package:iot_app/src/features/core/home/home_screen.dart';
import 'package:iot_app/src/features/gemini_chat/gemini_chat.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.route:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case WelcomScreen.route:
      return MaterialPageRoute(builder: (context) => const WelcomScreen());
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case SignUpScreen.route:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case HomeScreen.route:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case GeminiChat.route:
      return MaterialPageRoute(builder: (context) => const GeminiChat());
    default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

  }
}