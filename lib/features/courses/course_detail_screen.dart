import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course? course;

  const CourseDetailScreen({super.key, this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock Modules Data specific for this UI
  final List<Map<String, dynamic>> _meetings = [
    {
      'title': '01 - Pengantar User Interface Design',
      'stats': '3 URLs, 2 Files, 3 Interactive Content',
      'isCompleted': true, // Grey check
    },
    {
      'title': '02 - Konsep User Interface Design',
      'stats': '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
      'isCompleted': true, // Green check
    },
    {
      'title': '03 - Interaksi pada User Interface Design',
      'stats': '3 URLs, 2 Files, 3 Interactive Content',
      'isCompleted': true,
    },
    {
      'title': '04 - Ethnographic Observation',
      'stats': '3 URLs, 2 Files, 3 Interactive Content',
      'isCompleted': true,
    },
    {
      'title': '05 - UID Testing',
      'stats': '3 URLs, 2 Files, 3 Interactive Content',
      'isCompleted': true,
    },
    {
      'title': '06 - Assessment 1',
      'stats': '3 URLs, 2 Files, 3 Interactive Content',
      'isCompleted': true,
    },
  ];

  // Mock Assignments Data
  final List<Map<String, dynamic>> _assignments = [
    {
      'type': 'QUIZ',
      'title': 'Quiz Review 01',
      'deadline': '26 Februari 2021 23:59 WIB',
      'isCompleted': true,
      'icon': Icons.quiz_outlined, // Fallback icon, will try to use custom if possible or stick to Material
    },
    {
      'type': 'Tugas',
      'title': 'Tugas 01 - UID Android Mobile Game',
      'deadline': '26 Februari 2021 23:59 WIB',
      'isCompleted': true, // Grey/Pending
      'icon': Icons.assignment_outlined,
    },
    {
      'type': 'Pertemuan 3', // Label in screenshot says "Pertemuan 3" but icon is Quiz
      'title': 'Kuis - Assessment 2',
      'deadline': '26 Februari 2021 23:59 WIB',
      'isCompleted': true,
      'icon': Icons.quiz_outlined,
    },
  ];

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
    // Determine course title from widget.course or fallback default
    final courseTitle = widget.course?.title ?? 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA D4SM-42-03 [ADY]';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      body: Column(
        children: [
          // Custom Header
          Container(
            padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFFA82E2E), // Primary Red
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          courseTitle.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Custom Tab Bar Container
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.black87, width: 3),
                      insets: EdgeInsets.symmetric(horizontal: 40), // Short indicator
                    ),
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    tabs: const [
                      Tab(text: 'Materi'),
                      Tab(text: 'Tugas Dan Kuis'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Materi List with Animation
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _meetings.length,
                  itemBuilder: (context, index) {
                    final item = _meetings[index];
                    return _buildAnimatedCard(item, index);
                  },
                ),
                // Tugas List with Animation
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _assignments.length,
                  itemBuilder: (context, index) {
                    final item = _assignments[index];
                    return _buildAnimatedAssignmentCard(item, index);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(Map<String, dynamic> item, int index) {
    // ... (Existing Materi Card Logic)
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                     decoration: BoxDecoration(
                       color: const Color(0xFF5DADE2), // Light Blue
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: Text(
                       'Pertemuan ${index + 1}',
                       style: GoogleFonts.poppins(
                         color: Colors.white,
                         fontSize: 12,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ),
                   Icon(
                     Icons.check_circle,
                     color: index == 0 ? Colors.grey[400] : Colors.green, // Example logic
                     size: 24,
                   ),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Text(
                 item['title'],
                 style: GoogleFonts.poppins(
                   color: Colors.black87,
                   fontSize: 16,
                   fontWeight: FontWeight.w600,
                 ),
               ),
             ),
             const SizedBox(height: 24),
             Padding(
               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
               child: Text(
                 item['stats'],
                 style: GoogleFonts.poppins(
                   color: Colors.grey[400],
                   fontSize: 12,
                   fontWeight: FontWeight.normal,
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedAssignmentCard(Map<String, dynamic> item, int index) {
     return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Label and Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                     decoration: BoxDecoration(
                       color: const Color(0xFF5DADE2), // Light Blue
                       borderRadius: BorderRadius.circular(8), // More rectangular for assignments
                     ),
                     child: Text(
                       item['type'],
                       style: GoogleFonts.poppins(
                         color: Colors.white,
                         fontSize: 12,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ),
                   Icon(
                     Icons.check_circle,
                     color: item['title'].toString().contains('01') ? Colors.grey[400] : Colors.green, // Grey for middle item example
                     size: 24,
                   ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Icon and Title Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item['icon'], size: 40, color: Colors.black87),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title'],
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Footer: Deadline
              Text(
                'Tenggat Waktu : ${item['deadline']}',
                style: GoogleFonts.poppins(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}