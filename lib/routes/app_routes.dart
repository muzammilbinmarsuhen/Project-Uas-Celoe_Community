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
import '../features/kelas/presentation/pages/course_menu_page.dart';
import '../features/kelas/presentation/pages/material_detail_page.dart';
import '../features/kelas/presentation/pages/task_detail_page.dart';
import '../features/kelas/presentation/pages/quiz/quiz_overview_page.dart';
import '../features/kelas/presentation/pages/quiz/quiz_question_page.dart';
import '../features/kelas/presentation/pages/quiz/quiz_review_page.dart';
import '../features/kelas/presentation/pages/material/material_slide_page.dart';
import '../features/kelas/presentation/pages/material/video_material_page.dart';
import '../features/kelas/presentation/pages/assignment/assignment_detail_page.dart';
import '../features/kelas/presentation/pages/assignment/upload_file_page.dart';
import '../features/kelas/presentation/pages/material/article_list_page.dart';
import '../features/kelas/presentation/pages/material/article_detail_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home'; 
  static const String berita = '/berita';
  
  static const String profile = '/profile';
  static const String kelas = '/kelas';
  static const String notification = '/notification';
  static const String pengumuman = '/pengumuman';

  // NEW ROUTES
  static const String courseMenu = '/course-menu';
  static const String materialDetail = '/material-detail';
  static const String taskDetail = '/task-detail';

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
      courseMenu: (context) => const CourseMenuPage(),
      materialDetail: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as dynamic;
        return MaterialDetailPage(material: args);
      },
      taskDetail: (context) {
         final args = ModalRoute.of(context)!.settings.arguments as dynamic;
         return TaskDetailPage(task: args);
      },
      '/quiz-overview': (context) => const QuizOverviewPage(),
      '/quiz-start': (context) => const QuizQuestionPage(),
      '/quiz-review': (context) => const QuizReviewPage(),
      '/material-slide': (context) => const MaterialSlidePage(),
      '/material-video': (context) => const VideoMaterialPage(),
      '/assignment-detail': (context) => const AssignmentDetailPage(),
      '/upload-file': (context) => const UploadFilePage(),
      '/article-list': (context) => const ArticleListPage(),
      '/article-detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return ArticleDetailPage(article: args);
      },
    };
  }
}
