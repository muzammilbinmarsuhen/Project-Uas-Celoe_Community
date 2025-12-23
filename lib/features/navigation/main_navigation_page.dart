import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models.dart';
import '../../core/widgets/liquid_bottom_nav_bar.dart';
import '../dashboard/dashboard_screen.dart';
import '../kelas/kelas_page.dart';
import '../notifications/notifications_screen.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  bool _isLoading = true;

  User _user = User(
    id: '1',
    name: 'User',
    email: 'user@example.com',
    avatarUrl: 'https://via.placeholder.com/150',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    // 1. Try to get from arguments first (fastest)
    final args = ModalRoute.of(context)?.settings.arguments;
    String? name;
    String? email;
    if (args is String) {
      name = args;
      email = 'user@example.com'; // default
    } else if (args is Map<String, dynamic>) {
      name = args['username'];
      email = args['email'];
    }

    // 2. Fallback to SharedPreferences
    if (name == null || email == null) {
      final prefs = await SharedPreferences.getInstance();
      name ??= prefs.getString('username');
      email ??= prefs.getString('email');
    }

    if (mounted) {
      setState(() {
        _user = User(
          id: '1',
          name: name ?? 'User',
          email: email ?? 'user@example.com',
          avatarUrl: 'https://via.placeholder.com/150',
        );
        _isLoading = false;
      });
    }
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> pages = [
      DashboardScreen(username: _user.name, email: _user.email),
      const KelasPage(),
      const NotificationsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: LiquidBottomNavBar(
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
