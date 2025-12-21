import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models.dart';
import 'widgets/kelas_tab_bar_widget.dart';
import 'widgets/materi_card_widget.dart';
import 'widgets/tugas_kuis_card_widget.dart';
import 'widgets/empty_state_widget.dart';

class KelasPage extends StatefulWidget {
  final Course? course; // Optional, can be used for dynamic data later

  const KelasPage({super.key, this.course});

  @override
  State<KelasPage> createState() => _KelasPageState();
}

class _KelasPageState extends State<KelasPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock Data: Materi
  final List<Map<String, dynamic>> _materiList = [
    {
      'title': '01 - Pengantar User Interface Design',
      'subtext': '3 URLs, 2 Files, 3 Interactive Content',
      'isCompleted': true,
    },
    {
      'title': '02 - Konsep User Interface Design',
      'subtext': '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
      'isCompleted': true,
    },
    {
      'title': '03 - Interaksi pada User Interface Design',
      'subtext': '3 URLs, 2 Files, 3 Interactive Content',
      'isCompleted': true,
    },
    {
       'title': '04 - Ethnographic Observation',
       'subtext': '3 URLs, 2 Files, 3 Interactive Content',
       'isCompleted': true,
    },
    {
       'title': '05 - UID Testing',
       'subtext': '3 URLs, 2 Files, 3 Interactive Content',
       'isCompleted': true,
    },
    {
       'title': '06 - Assessment 1',
       'subtext': '3 URLs, 2 Files, 3 Interactive Content',
       'isCompleted': true,
    },
  ];

  // Mock Data: Tugas & Kuis
  final List<Map<String, dynamic>> _tugasKuisList = [
    {
      'type': 'QUIZ',
      'title': 'Quiz Review 01',
      'deadline': '26 Februari 2021 23:59 WIB',
      'isCompleted': true,
      'icon': Icons.chat_bubble_outline,
    },
    {
      'type': 'Tugas',
      'title': 'Tugas 01 - UID Android Mobile Game',
      'deadline': '26 Februari 2021 23:59 WIB',
      'isCompleted': true, // Pending/Grey
      'icon': Icons.description_outlined,
    },
    {
       'type': 'Pertemuan 3',
       'title': 'Kuis - Assessment 2',
       'deadline': '26 Februari 2021 23:59 WIB',
       'isCompleted': true,
       'icon': Icons.chat_bubble_outline,
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
    // Dynamic or Fallback Title
    final String courseTitle = widget.course?.title ?? 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA D4SM-42-03 [ADY]';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // 1. APP BAR
          // We use a custom container to achieve the specific rounded bottom corners + content layout
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16, // SafeArea top
              left: 16,
              right: 16,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFA82E2E), // Merah LMS
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Back Button & Title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
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
                
                // 2. TAB BAR (DI BAWAH APP BAR)
                KelasTabBarWidget(controller: _tabController),
              ],
            ),
          ),

          // 3. & 4. TAB VIEWS
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // TAB "MATERI"
                _buildMateriList(),

                // TAB "TUGAS DAN KUIS"
                _buildTugasKuisList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMateriList() {
    if (_materiList.isEmpty) {
      return const EmptyStateWidget(message: 'Tidak Ada Materi Hari Ini'); // Reuse for consisteny
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _materiList.length,
      itemBuilder: (context, index) {
        final item = _materiList[index];
        
        // Simple Staggered Animation Logic
        // We can wrap this in a TweenAnimationBuilder inside the widget or here. 
        // For cleaner code, we can pass an animation controller or just use the widget's internal builder
        
        return TweenAnimationBuilder<double>(
           tween: Tween(begin: 0, end: 1),
           duration: Duration(milliseconds: 400 + (index * 100)),
           curve: Curves.easeOutQuart,
           builder: (context, value, child) {
             return MateriCardWidget(
               index: index,
               title: item['title'],
               subtext: item['subtext'],
               isCompleted: item['isCompleted'],
               animation: AlwaysStoppedAnimation(value), // Pass current animation value
               onTap: () {
                 // Open Detail View (Section 5)
                 // Navigator.push(...)
               },
             );
           }, 
        );
      },
    );
  }

  Widget _buildTugasKuisList() {
    if (_tugasKuisList.isEmpty) {
       return const EmptyStateWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _tugasKuisList.length,
      itemBuilder: (context, index) {
        final item = _tugasKuisList[index];

        return TweenAnimationBuilder<double>(
           tween: Tween(begin: 0, end: 1),
           duration: Duration(milliseconds: 400 + (index * 100)),
           curve: Curves.easeOutQuart,
           builder: (context, value, child) {
             return TugasKuisCardWidget(
               item: item,
               animation: AlwaysStoppedAnimation(value),
             );
           },
        );
      },
    );
  }
}
