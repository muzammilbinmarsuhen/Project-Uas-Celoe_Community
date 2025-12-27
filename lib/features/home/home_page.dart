import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../kelas/kelas_page.dart';
import '../notification/notification_page.dart';
import 'dashboard_content_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_controller.dart'; 

class HomePage extends ConsumerStatefulWidget {
  final Map<String, dynamic>? args;
  const HomePage({super.key, this.args});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    final userData = widget.args ?? {'username': 'Guest', 'email': 'guest@example.com'};
    _pages = [
      DashboardContentPage(userData: userData),
      const KelasPage(),
      const NotifikasiPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(dashboardControllerProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(dashboardControllerProvider.notifier).setIndex(index);
        },
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.primaryMaroon.withValues(alpha: 0.1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppTheme.primaryMaroon),
            label: 'Home',
          ),
          NavigationDestination(
             icon: Icon(Icons.school_outlined),
             selectedIcon: Icon(Icons.school, color: AppTheme.primaryMaroon),
             label: 'Kelas Saya',
          ),
           NavigationDestination(
             icon: Icon(Icons.notifications_outlined),
             selectedIcon: Icon(Icons.notifications, color: AppTheme.primaryMaroon),
             label: 'Notifikasi',
          ),
        ],
      ),
    );
  }
}
