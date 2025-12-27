import 'package:flutter/material.dart';

import '../features/splash/splash_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/auth/forgot_password_page.dart';
import '../features/home/home_page.dart'; 
import '../features/berita/presentation/pages/berita_page.dart';
import '../features/notification/notification_page.dart';
import '../features/kelas/kelas_page.dart';
import '../features/pengumuman/presentation/pages/pengumuman_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home'; 
  static const String berita = '/berita';
  
  // Future routes
  static const String profile = '/profile';
  static const String kelas = '/kelas';
  static const String notification = '/notification';
  static const String pengumuman = '/pengumuman';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(), 
      login: (context) => const LoginPage(),
      register: (context) => const RegisterPage(),
      forgotPassword: (context) => const ForgotPasswordPage(),
      home: (context) => const HomePage(),
      berita: (context) => const BeritaPage(),
      kelas: (context) => const KelasPage(),
      notification: (context) => const NotifikasiPage(),
      pengumuman: (context) => const PengumumanPage(),
    };
  }
}
