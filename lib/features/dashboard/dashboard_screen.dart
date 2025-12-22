import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/models.dart';
import '../profil/profil_page.dart';

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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Upcoming Task
                    SlideTransition(
                      position: _taskSlide,
                      child: FadeTransition(
                        opacity: _taskFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'Prioritas Hari Ini',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildPremiumTaskCard(),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 3. Announcements
                    SlideTransition(
                      position: _announceSlide,
                      child: FadeTransition(
                        opacity: _announceFade,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Info Kampus',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Semua',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFA82E2E),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoCard(),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 4. Course Progress
                    SlideTransition(
                      position: _courseSlide,
                      child: FadeTransition(
                        opacity: _courseFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lanjutkan Belajar',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Horizontal Scroll list
                            SizedBox(
                              height: 140, 
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                clipBehavior: Clip.none,
                                children: [
                                  _buildMiniCourseCard(
                                    title: "Flutter Basics", 
                                    progress: 0.75, 
                                    color: Colors.blueAccent
                                  ),
                                  const SizedBox(width: 16),
                                  _buildMiniCourseCard(
                                    title: "UI/UX Design", 
                                    progress: 0.40, 
                                    color: Colors.orangeAccent
                                  ),
                                  const SizedBox(width: 16),
                                  _buildMiniCourseCard(
                                    title: "Python Data", 
                                    progress: 0.10, 
                                    color: Colors.greenAccent
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Vertical list for latest specific course
                             _buildCourseCard(
                              imageUrl: 'https://via.placeholder.com/150',
                              semester: '2021/2',
                              title: 'Bahasa Inggris: Business and Scientific',
                              progress: 0.90,
                              backgroundColor: Colors.indigoAccent,
                            ),
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
    
    // Logic to determine ImageProvider for the small avatar
    ImageProvider avatarImage;
    if (widget.userAvatar != null) {
      if (kIsWeb) {
        avatarImage = NetworkImage(widget.userAvatar!.path);
      } else {
        avatarImage = FileImage(File(widget.userAvatar!.path));
      }
    } else {
       avatarImage = const NetworkImage('https://via.placeholder.com/150');
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFFA82E2E), // Primary Red
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        boxShadow: [
          BoxShadow(
             color: Color(0x40A82E2E),
             blurRadius: 24,
             offset: Offset(0, 12),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT: Greeting and Name
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, Selamat Pagi',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.username,
                   style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // RIGHT: 'Mahasiswa' Card AND Logout Button
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilPage(
                        user: User(
                          id: 'user_1',
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
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          image: DecorationImage(
                            image: avatarImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Mahasiswa',
                        style: GoogleFonts.poppins(
                           color: Colors.white,
                           fontSize: 13,
                           fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // LOGOUT BUTTON
              Material(
                color: const Color(0xFF8B1A1A), // Darker shade of red
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 22),
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

  Widget _buildPremiumTaskCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFB91C1C), const Color(0xFFEF4444)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB91C1C).withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(Icons.assignment_outlined, size: 100, color: Colors.white.withValues(alpha: 0.1)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Deadline Segera',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Desain UI/UX Mobile',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tugas 01 - Wireframing',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                 children: [
                   const Icon(Icons.access_time_rounded, color: Colors.white, size: 16),
                   const SizedBox(width: 8),
                   Text(
                     'Besok, 23:59 WIB',
                     style: GoogleFonts.poppins(
                       color: Colors.white,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: const [
          BoxShadow(
             color: Colors.black12,
             blurRadius: 15,
             offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50, width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.campaign_outlined, color: Colors.orange, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maintenance Sistem',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'Sistem akan down pada Sabtu malam.',
                  style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMiniCourseCard({required String title, required double progress, required Color color}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
             padding: const EdgeInsets.all(8),
             decoration: BoxDecoration(
               color: color.withValues(alpha: 0.1),
               shape: BoxShape.circle,
             ),
             child: Icon(Icons.class_rounded, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                maxLines: 1, 
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[100],
                valueColor: AlwaysStoppedAnimation(color),
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          )
        ],
      ),
    );
  }
  
  Widget _buildCourseCard({
    required String imageUrl,
    required String semester,
    required String title,
    required double progress,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: backgroundColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.book_rounded,
              color: backgroundColor,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  semester,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(height: 6, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(3))),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
