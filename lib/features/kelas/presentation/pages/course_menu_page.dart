import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/material_tab.dart';
import '../widgets/assignment_tab.dart';

class CourseMenuPage extends StatefulWidget {
  const CourseMenuPage({super.key});

  @override
  State<CourseMenuPage> createState() => _CourseMenuPageState();
}

class _CourseMenuPageState extends State<CourseMenuPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFFA82E2E), // Maroon
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: TweenAnimationBuilder<double>(
            tween: Tween(begin: -20, end: 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: Opacity(
                  opacity: (value + 20) / 20, // Fade in sync with slide
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                Text(
                  'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  'D4SM-42-03 [ADY]',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black, // Active indicator black as requested
              indicatorWeight: 3,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
              unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14),
              tabs: const [
                Tab(text: 'Materi'),
                Tab(text: 'Tugas dan Kuis'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                MaterialTab(),
                AssignmentTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container( // Fixed Bottom Nav
         height: 70,
         decoration: BoxDecoration(
            color: const Color(0xFFA82E2E),
            boxShadow: [
               BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -4))
            ]
         ),
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               _buildNavItem(Icons.home, 'Home', false),
               _buildNavItem(Icons.school, 'Kelas Saya', true),
               _buildNavItem(Icons.notifications, 'Notifikasi', false),
            ],
         ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(icon, color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.6), size: 24),
           const SizedBox(height: 4),
           Text(label, style: GoogleFonts.poppins(color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.6), fontSize: 10))
        ],
     );
  }
}
