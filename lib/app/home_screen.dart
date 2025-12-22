import 'package:flutter/material.dart';
import '../core/models.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/courses/courses_screen.dart';
import '../features/profil/profil_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _username = 'Mahasiswa'; // Default fallback

  // Mock data
  late User currentUser;
  late List<Course> allCourses;
  late List<Widget> _screens;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Retrieve username from arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _username = args;
    }

    currentUser = User(
      id: '1',
      name: _username,
      email: 'student@celoe.com', // Placeholder
      avatarUrl: 'https://via.placeholder.com/150',
    );

    allCourses = [
      Course(
        id: '1',
        title: 'Introduction to Flutter',
        description: 'Learn the basics of Flutter development.',
        instructor: 'Jane Smith',
        progress: 0.6,
        modules: [
            // ... (keeping existing mock data structure if needed, or simple list)
        ],
      ),
    ];

    _screens = [
      DashboardScreen(username: _username),
      CoursesScreen(courses: allCourses),
      ProfilPage(user: currentUser),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for curved navbar effect
      body: _screens.length > _selectedIndex ? _screens[_selectedIndex] : _screens[0],
      bottomNavigationBar: Container(
        height: 70, // Fixed height for custom bar
        decoration: const BoxDecoration(
          color: Color(0xFFA82E2E), // Primary Red
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10, offset: Offset(0, -2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedNavItem(0, Icons.home_rounded, 'Home'),
            _buildAnimatedNavItem(1, Icons.school_rounded, 'Kelas Saya'),
            _buildAnimatedNavItem(2, Icons.person_rounded, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2), // Semi-transparent white pill
                borderRadius: BorderRadius.circular(25),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.2 : 1.0, // Scale up icon
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}