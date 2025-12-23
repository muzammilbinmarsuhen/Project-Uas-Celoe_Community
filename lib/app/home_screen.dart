import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'package:flutter/material.dart';
import '../core/models.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/courses/courses_screen.dart';
import '../features/notifications/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _username = 'Mahasiswa'; // Default fallback
  String _email = 'student@celoe.com'; // Default
  XFile? _avatarFile; // Store the avatar file

  // Mock data
  late User currentUser;
  // late List<Widget> _screens; // Removed to build dynamically

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Retrieve arguments (Map or String)
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
       _username = args['username'] ?? 'Mahasiswa';
       _email = args['email'] ?? 'student@celoe.com';
    } else if (args is String) {
       _username = args;
    }

    currentUser = User(
      id: '1',
      name: _username,
      email: _email, // Placeholder
      avatarUrl: 'https://via.placeholder.com/150',
    );

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleAvatarChanged(XFile newFile) {

    setState(() {
      _avatarFile = newFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild screens to pass updated state
    final List<Widget> screens = [
      DashboardScreen(
        username: _username,
        email: _email, // Passed email
        userAvatar: _avatarFile,
        onAvatarChanged: _handleAvatarChanged,
      ),
      const CoursesScreen(),
      const NotificationScreen(), 
    ];

    return Scaffold(
      extendBody: true, // Important for curved navbar effect
      body: screens.length > _selectedIndex ? screens[_selectedIndex] : screens[0],
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
            _buildAnimatedNavItem(2, Icons.notifications_rounded, 'Notifikasi'),
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