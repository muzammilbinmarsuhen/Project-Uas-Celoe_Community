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

  // Mock data
  final User currentUser = User(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    avatarUrl: 'https://via.placeholder.com/150',
  );

  final List<Course> allCourses = [
    Course(
      id: '1',
      title: 'Introduction to Flutter',
      description: 'Learn the basics of Flutter development.',
      instructor: 'Jane Smith',
      progress: 0.6,
      modules: [
        Module(
          id: '1',
          title: 'Getting Started',
          type: 'video',
          contentUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          isCompleted: true,
        ),
        Module(
          id: '2',
          title: 'Widgets Overview',
          type: 'text',
          contentUrl: 'This is the content for Widgets Overview.',
          isCompleted: false,
          quiz: Quiz(
            id: '1',
            questions: [
              QuizQuestion(
                id: '1',
                question: 'What is Flutter?',
                options: ['A framework', 'A language', 'An IDE', 'A database'],
                correctIndex: 0,
              ),
            ],
          ),
        ),
      ],
    ),
    Course(
      id: '2',
      title: 'Advanced Dart',
      description: 'Deep dive into Dart programming.',
      instructor: 'Bob Johnson',
      progress: 0.3,
      modules: [],
    ),
  ];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(),
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
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'KELAS SAYA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'NOTIFIKASI',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFB22222),
        onTap: _onItemTapped,
      ),
    );
  }
}