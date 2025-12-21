import 'package:flutter/material.dart';
import '../core/models.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/courses/courses_screen.dart';
import '../features/profile/profile_screen.dart';

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
      ProfileScreen(user: currentUser),
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school_rounded), // Changed to school cap icon
                label: 'Kelas Saya',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_rounded),
                label: 'Notifikasi',
              ),
            ],
            currentIndex: _selectedIndex,
            backgroundColor: const Color(0xFFA82E2E), // Primary Red
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }
}