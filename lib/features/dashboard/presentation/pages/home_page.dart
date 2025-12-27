import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/data/dummy_data.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/announcement_carousel_widget.dart';
import '../../widgets/course_progress_card_widget.dart';

import '../../../../features/pengaduan/presentation/pages/pengaduan_page.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';

class HomePage extends ConsumerStatefulWidget {
  final Map<String, dynamic> userData;

  const HomePage({super.key, required this.userData});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final programs = DummyData.courses; 

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              FadeTransition(
                opacity: _fadeAnimation,
                child: HeaderWidget(
                  username: widget.userData['username'] ?? 'User',
                  avatarUrl: null, // to be implemented with real profile
                  onProfileTap: () {
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ProfilePage(userData: widget.userData)),
                     );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Tugas Akan Datang (Highlight Section)
                    _buildTaskCard(context),
                    
                    const SizedBox(height: 24),

                    // 3. Shortcuts / Quick Menu
                    Text(
                      'Menu Cepat',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildShortcutItem(context, ref, Icons.campaign, 'Pengumuman', Colors.orange, () {
                           Navigator.pushNamed(context, '/pengumuman');
                        }),
                        _buildShortcutItem(context, ref, Icons.report_problem, 'Pengaduan', Colors.red, () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PengaduanPage()),
                           );
                        }),
                        _buildShortcutItem(context, ref, Icons.article, 'Berita', Colors.blue, () {
                           Navigator.pushNamed(context, '/berita');
                        }),
                        _buildShortcutItem(context, ref, Icons.info_outline, 'Tentang', Colors.purple, () {
                           // Show Dialog or Navigate
                        }),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // 3. Announcements
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Info Terkini',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Lihat Semua',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFA82E2E),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const AnnouncementCarouselWidget(),

                    const SizedBox(height: 32),

                    // 4. Programs / Activities (Reusing Course Card for now)
                    Text(
                      'Program LSM',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...programs.map((program) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CourseProgressCardWidget(
                        course: program,
                        onTap: () {}, // Navigate to detail
                      ),
                    )),
                    
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutItem(BuildContext context, WidgetRef ref, IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(label, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context) {
    return Container(
       width: double.infinity,
       padding: const EdgeInsets.all(20),
       decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
             colors: [Color(0xFFA82E2E), Color(0xFFC62828)],
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
          ),
          boxShadow: [
             BoxShadow(
                color: const Color(0xFFA82E2E).withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
             )
          ],
       ),
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.2),
                         borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                         'Deadline Terdekat',
                         style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                   ),
                   const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
                ],
             ),
             const SizedBox(height: 12),
             Text(
                'Desain Mockup UI/UX',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 4),
             Text(
                'Tenggat: 28 Des 2025 • 23:59',
                style: GoogleFonts.poppins(color: Colors.white.withValues(alpha: 0.9), fontSize: 12),
             ),
             const SizedBox(height: 16),
             SizedBox( // Ensure button stretches but has constraint
                width: double.infinity,
                child: ElevatedButton(
                   onPressed: () {}, 
                   style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFA82E2E),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                   ),
                   child: const Text('Kumpulkan Tugas'),
                ),
             ),
          ],
       ),
    );
  }
}
