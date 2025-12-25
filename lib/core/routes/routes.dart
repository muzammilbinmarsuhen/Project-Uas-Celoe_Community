import 'package:flutter/material.dart';
import '../../features/auth/login_page.dart';

import '../../features/navigation/main_navigation_page.dart';

import '../../features/splash/splash_page.dart'; // Import Splash

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home'; // Main Navigation
  static const String courseDetail = '/course-detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(), 
      login: (context) => const LoginPage(),
      home: (context) => const MainNavigationPage(),
    };
  }
}
