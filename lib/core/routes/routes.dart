import 'package:flutter/material.dart';
import '../../features/berita/presentation/pages/berita_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/splash/splash_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/register_page.dart';
import '../../features/auth/forgot_password_page.dart';


class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home'; 

  static const String berita = '/berita';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(), 
      login: (context) => const LoginPage(),
      register: (context) => const RegisterPage(),
      forgotPassword: (context) => const ForgotPasswordPage(),
      home: (context) => DashboardPage(args: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?),
      berita: (context) => const BeritaPage(),
    };
  }
}
