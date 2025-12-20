import 'package:flutter/material.dart';
import '../features/splash/splash_page.dart';
import '../features/auth/login_page.dart';
import 'home_screen.dart';
import '../features/courses/course_detail_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String courseDetail = '/course_detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(),
      login: (context) => const LoginPage(),
      home: (context) => const HomeScreen(),
      courseDetail: (context) => const CourseDetailScreen(),
    };
  }
}