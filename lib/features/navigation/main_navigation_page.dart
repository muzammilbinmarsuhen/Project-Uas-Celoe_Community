import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../../core/data/dummy_data.dart';
import '../../core/widgets/liquid_bottom_nav_bar.dart';
import '../dashboard/dashboard_screen.dart';
import '../courses/courses_screen.dart';
import '../notifications/notifications_page.dart'; // Correct import

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  // User state
  User _user = DummyData.currentUser;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        // Create new User object from arguments
        _user = User(
          id: 1, // Default ID 
          username: args['username'] ?? _user.username,
          email: args['email'] ?? _user.email,
          avatarUrl: _user.avatarUrl,
        );
      }
      _isInit = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Smooth animate to page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuad,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pages for the PageView
    final List<Widget> pages = [
      DashboardScreen(
        username: _user.username, // Correct property
        email: _user.email,
        // userAvatar: _user.avatarUrl, // If needed by Dashboard
      ),
      const CoursesScreen(), // Will need refactor to CourseListScreen
      const NotifikasiPage(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(), // Smooth physics
        children: pages,
      ),
      bottomNavigationBar: LmsBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        icons: const [
          Icons.home_rounded,
          Icons.school_rounded,
          Icons.notifications_rounded,
        ],
      ),
    );
  }
}
