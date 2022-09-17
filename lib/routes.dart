import 'package:flutter/material.dart';
import 'package:login/core/protected_route.dart';
import 'package:login/middlewares/is_authenticated.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/register_screen.dart';
import 'package:login/screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    '/': (context) => const SplashScreen(key: Key('splash_screen')),
    '/login': (context) => const LoginScreen(key: Key('login_screen')),
    '/register': (context) => const RegisterScreen(key: Key('register_screen')),
    '/home': (context) => ProtectedRoute(
          screen: const HomeScreen(key: Key('home_screen')),
          middlewares: [IsAuthenticated()],
        ),
  };
}
