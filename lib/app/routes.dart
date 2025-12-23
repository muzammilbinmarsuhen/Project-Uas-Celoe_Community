import 'package:flutter/material.dart';
import '../features/splash/splash_page.dart';
import '../features/auth/login_page.dart';
import '../features/navigation/main_navigation_page.dart';
import '../features/courses/course_detail_screen.dart';
import '../core/widgets/anti_gravity_preview.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String courseDetail = '/course_detail';
  static const String antiGravityPreview = '/antigravity';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(),
      login: (context) => const LoginPage(),
      home: (context) => const MainNavigationPage(),
      courseDetail: (context) => const CourseDetailScreen(),
      antiGravityPreview: (context) => const AntiGravityPreview(),
    };
  }
}