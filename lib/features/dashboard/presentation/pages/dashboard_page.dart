import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/kelas_saya/presentation/pages/kelas_saya_page.dart';
import '../../../../features/notifications/notifications_page.dart';
import 'home_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/dashboard_controller.dart';

class DashboardPage extends ConsumerStatefulWidget {
  final Map<String, dynamic>? args;
  const DashboardPage({super.key, this.args});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    final userData = widget.args ?? {'username': 'Guest', 'email': 'guest@example.com'};
    _pages = [
      HomePage(userData: userData),
      const KelasSayaPage(),
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
