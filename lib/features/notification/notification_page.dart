import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Static Dummy Data as per request (mocking Kuis/Tugas types)
  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'tugas', // 'tugas' or 'kuis'
      'title': 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      'time': '3 Hari 9 Jam Yang Lalu',
    },
    {
      'type': 'kuis',
      'title': 'Anda telah menyelesaikan Quiz Review 01 dengan nilai 85',
      'time': '5 Hari 2 Jam Yang Lalu',
    },
    {
      'type': 'tugas',
      'title': 'Tugas Baru: Implementasi User Interface dengan Flutter telah dirilis',
      'time': '1 Minggu Yang Lalu',
    },
    {
      'type': 'kuis',
      'title': 'Pengingat: Kuis Logika Algoritma akan dimulai dalam 2 jam',
      'time': '1 Minggu Yang Lalu',
    },
     {
      'type': 'tugas',
      'title': 'Anda telah mengirimkan pengajuan tugas untuk Perancangan Database NGO',
      'time': '2 Minggu Yang Lalu',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(), 
        ),
        title: Text(
          'Notifikasi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16, // Matches "Notifikasi" title size typical in design
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0, // Sticky behavior without shadow color change
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20), // Padding between items
        itemBuilder: (context, index) {
          final item = _notifications[index];
          
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2), // Slight slide up
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  index * 0.1, 
                  1.0, 
                  curve: Curves.easeOutQuad
                ),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    index * 0.1, 
                    1.0, 
                    curve: Curves.easeOut
                  ),
                ),
              ),
              child: _buildNotificationItem(context, item),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, Map<String, dynamic> item) {
    bool isTask = item['type'] == 'tugas';

    return InkWell(
      onTap: () {
        // Placeholder navigation
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Navigate to Detail...')),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Left
          Container(
             width: 40,
             height: 40,
             decoration: BoxDecoration(
                color: isTask ? Colors.blue.withValues(alpha: 0.1) : Colors.purple.withValues(alpha: 0.1),
                shape: BoxShape.circle,
             ),
             child: Icon(
                isTask ? Icons.description_outlined : Icons.quiz_outlined,
                color: isTask ? Colors.blue : Colors.purple,
                size: 20,
             ),
          ),
          const SizedBox(width: 16),
          
          // Right Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 13, // Readability for multi-line
                    fontWeight: FontWeight.bold, // Title Bold
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['time'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[500], // Muted time
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
