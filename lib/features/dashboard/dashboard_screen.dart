import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/models.dart';
import '../profil/profil_page.dart';
import '../kelas/kelas_page.dart';

import '../notifikasi/pengumuman_page.dart';
import '../notifikasi/pengumuman_detail_page.dart';
import '../kelas/tugas_detail_page.dart';

class DashboardScreen extends StatefulWidget {
  final String username;
  final String email; // Added email
  final XFile? userAvatar; 
  final Function(XFile)? onAvatarChanged; 

  const DashboardScreen({
    super.key, 
    required this.username,
    required this.email, // Added required
    this.userAvatar,
    this.onAvatarChanged,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  // Staggered Animations
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _taskFade;
  late Animation<Offset> _taskSlide;
  late Animation<double> _announceFade;
  late Animation<Offset> _announceSlide;
  late Animation<double> _courseFade;
  late Animation<Offset> _courseSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
       duration: const Duration(milliseconds: 1200),
       vsync: this,
    );

    // Helper to create staggered interval
    Animation<double> createFade(double begin, double end) {
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeOut),
      );
    }
    Animation<Offset> createSlide(double begin, double end) {
      return Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(begin, end, curve: Curves.easeOutCubic),
        ),
      );
    }

    _headerFade = createFade(0.0, 0.4);
    _headerSlide = createSlide(0.0, 0.4);

    _taskFade = createFade(0.2, 0.6);
    _taskSlide = createSlide(0.2, 0.6);

    _announceFade = createFade(0.4, 0.8);
    _announceSlide = createSlide(0.4, 0.8);

    _courseFade = createFade(0.6, 1.0);
    _courseSlide = createSlide(0.6, 1.0);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section
              SlideTransition(
                position: _headerSlide,
                child: FadeTransition(
                  opacity: _headerFade,
                  child: _buildHeader(context),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Upcoming Task (Priority)
                    SlideTransition(
                      position: _taskSlide,
                      child: FadeTransition(
                        opacity: _taskFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                               'Tugas Yang Akan Datang',
                               style: GoogleFonts.poppins(
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black87,
                               ),
                             ),
                            const SizedBox(height: 12),
                            GestureDetector(
                                onTap: () {
                                  // Direct navigation to Task/Assignment Detail
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TugasDetailPage(
                                            assignmentId: 101, // Mock
                                            title: 'Tugas 01 - UID Android Mobile Game',
                                            deadline: 'Jumat, 26 Februari | 23:59 WIB'
                                        )
                                    ),
                                  );
                                },
                                child: _buildPriorityTaskCard(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 3. Announcements
                    SlideTransition(
                      position: _announceSlide,
                      child: FadeTransition(
                        opacity: _announceFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pengumuman Terakhir',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => const PengumumanPage()));
                                  },
                                  child: Text(
                                    'Lihat Semua',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFA82E2E), // Maroon
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildAnnouncementCard(context),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 4. Course Progress (Scrollable Vertical List)
                    SlideTransition(
                      position: _courseSlide,
                      child: FadeTransition(
                        opacity: _courseFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progres Kelas',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Vertical List only
                            _buildCourseList(context),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    ImageProvider avatarImage;
    if (widget.userAvatar != null) {
      avatarImage = NetworkImage(widget.userAvatar!.path);
    } else {
       avatarImage = const NetworkImage('https://via.placeholder.com/150');
    }

    // Personalized Text
    final String greetingName = widget.username.isEmpty ? 'MAHASISWA' : widget.username.toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFFA82E2E), // Red Background
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
             color: Color(0x40A82E2E),
             blurRadius: 15,
             offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Greeting Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hallo,',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  greetingName,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Badge + Logout
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilPage(
                        user: User(
                          id: '1', 
                          name: widget.username,
                          email: widget.email,
                          avatarUrl: 'https://via.placeholder.com/150',
                        ),
                        initialImage: widget.userAvatar, 
                        onImageChanged: widget.onAvatarChanged,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white, // White Badge
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Text(
                        'MAHASISWA',
                        style: GoogleFonts.poppins(
                           color: const Color(0xFFA82E2E), // Red Text
                           fontSize: 11,
                           fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: avatarImage,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // LOGOUT BUTTON (Preserved)
              Material(
                color: Colors.white.withValues(alpha: 0.2), // Semi-transparent white
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: const Text("Logout"),
                          content: const Text("Apakah anda yakin ingin keluar?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Batal"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context); // Close Dialog
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.clear(); // Clear Session
                                if (context.mounted) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context, 
                                    AppRoutes.login, 
                                    (route) => false
                                  );
                                }
                              },
                              child: const Text("Ya, Keluar", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityTaskCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFA82E2E), // Merah
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA82E2E).withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Tugas 01 – UID Android Mobile Game',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          
          Center(
            child: Column(
              children: [
                Text(
                  'Waktu Pengumpulan',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
                 Text(
                  'Jumat 26 Februari, 23:59 WIB',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => const PengumumanDetailPage(index: 0)));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
             BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  // Placeholder for LMS / Announcement generic image
                  image: AssetImage('assets/images/Learning Management System.png'), 
                  fit: BoxFit.cover,
                ),
              ),
              child: const Icon(Icons.campaign, color: Colors.grey), // Fallback
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maintenance Pra UAS Semester Genap',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '10 Jan 2024 • Admin CeLOE',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList(BuildContext context) {
    // Exact list from the prompt image
    final courses = [
      {'title': 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA D4SM-42-03 [ADY]', 'progress': 0.89, 'img': 'assets/images/ui_ux.png', 'color': Colors.orangeAccent, 'semester': '2021/2'},
      {'title': 'KEWARGANEGARAAN\nD4SM-41-GAB1 [BBO], JUMAT 2', 'progress': 0.58, 'img': 'assets/images/garuda.png', 'color': Colors.redAccent, 'semester': '2021/2'},
      {'title': 'SISTEM OPERASI\nD4SM-44-02 [DDS]', 'progress': 0.90, 'img': 'assets/images/os.png', 'color': Colors.blueGrey, 'semester': '2021/2'},
      {'title': 'PEMROGRAMAN PERANGKAT BERGERAK MULTIMEDIA\nD4SM-41-GAB1 [APJ]', 'progress': 0.90, 'img': 'assets/images/mobile.png', 'color': Colors.cyan, 'semester': '2021/2'},
      {'title': 'BAHASA INGGRIS: BUSINESS AND SCIENTIFIC\nD4SM-41-GAB1 [ARS]', 'progress': 0.90, 'img': 'assets/images/english.png', 'color': Colors.grey, 'semester': '2021/2'},
      {'title': 'PEMROGRAMAN MULTIMEDIA INTERAKTIF\nD4SM-43-04 [TPR]', 'progress': 0.90, 'img': 'assets/images/interactive.png', 'color': Colors.blue[800], 'semester': '2021/2'},
      {'title': 'OLAH RAGA\nD3TT-44-02 [EYR]', 'progress': 0.90, 'img': 'assets/images/sports.png', 'color': Colors.purpleAccent, 'semester': '2021/2'},
    ];

    return Column(
      children: courses.map((course) {
        return GestureDetector(
          onTap: () {
            // 1-Click to Materials
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KelasPage(
                  courseId: 1, // Mock
                  title: (course['title'] as String).split('\n')[0], // Use first line as title
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(0),
            color: Colors.transparent, // clean layout
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 // Thumbnail (Visual representation)
                 Container(
                   width: 80, height: 80,
                   decoration: BoxDecoration(
                     color: (course['color'] as Color?)?.withValues(alpha: 0.2) ?? Colors.grey[200],
                     borderRadius: BorderRadius.circular(4), // Slightly square as in image
                   ),
                   alignment: Alignment.center,
                   child: Text(
                     (course['title'] as String).substring(0, 1),
                     style: GoogleFonts.poppins(
                       fontSize: 32, 
                       fontWeight: FontWeight.bold, 
                       color: course['color'] as Color?
                     ),
                   ),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         course['semester'] as String,
                         style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 10),
                       ),
                       const SizedBox(height: 4),
                       Text(
                         course['title'] as String,
                         style: GoogleFonts.poppins(
                           color: Colors.black87,
                           fontSize: 12, // Compact font
                           fontWeight: FontWeight.bold,
                           height: 1.3,
                         ),
                       ),
                       const SizedBox(height: 8),
                       // Progress
                       ClipRRect(
                         borderRadius: BorderRadius.circular(4),
                         child: LinearProgressIndicator(
                           value: course['progress'] as double,
                           minHeight: 8,
                           backgroundColor: Colors.grey[200],
                           valueColor: const AlwaysStoppedAnimation(Color(0xFFA82E2E)),
                         ),
                       ),
                       const SizedBox(height: 4),
                       Text(
                         '${((course['progress'] as double) * 100).toInt()}% Selesai',
                         style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 10),
                       ),
                     ],
                   ),
                 )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

}
