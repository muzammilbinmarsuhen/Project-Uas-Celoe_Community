import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../kelas/materi_detail_page.dart';
import '../kelas/tugas_detail_page.dart';
import '../kelas/quiz/quiz_intro_page.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      timestamp: '3 Hari 9 Jam Yang Lalu',
      type: NotificationType.document,
    ),
    NotificationItem(
      title: 'Kuis "Konsep Dasar Pemrograman" akan segera dimulai dalam 1 jam.',
      timestamp: '1 Hari 2 Jam Yang Lalu',
      type: NotificationType.quiz,
    ),
    NotificationItem(
      title: 'Materi baru "Pengenalan Flutter" telah ditambahkan ke kelas Mobile Programming.',
      timestamp: '2 Hari Yang Lalu',
      type: NotificationType.document,
    ),
    NotificationItem(
      title: 'Reminder: Deadline tugas "Analisis Algoritma" besok malam.',
      timestamp: '4 Hari Yang Lalu',
      type: NotificationType.quiz,
    ),
     NotificationItem(
      title: 'Nilai untuk Assessment 2 telah dipublikasikan. Silakan cek di menu Nilai.',
      timestamp: '5 Hari Yang Lalu',
      type: NotificationType.document,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  index * 0.1,
                  1.0,
                  curve: Curves.easeOutCubic,
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
                    curve: Curves.easeOut,
                  ),
                ),
              ),
              child: _NotificationCard(item: item),
            ),
          );
        },
      ),
    );
  }
}

enum NotificationType { document, quiz }

class NotificationItem {
  final String title;
  final String timestamp;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.timestamp,
    required this.type,
  });
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            debugPrint("Notification tapped: ${item.title}");
            
            // Basic Logic to route based on Title keywords or Type
            // In a real app, NotificationItem would have a 'targetId' and 'route'
            if (item.type == NotificationType.quiz || item.title.toLowerCase().contains('kuis')) {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizIntroPage(title: 'Kuis - Notifikasi')),
               );
            } else if (item.title.toLowerCase().contains('tugas') || item.title.toLowerCase().contains('assessment')) {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TugasDetailPage(title: 'Detail Tugas', deadline: 'Besok')),
               );
            } else {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MateriDetailPage(title: 'Materi Terkait')),
               );
            }
          },
          highlightColor: const Color(0xFFB22222).withValues(alpha: 0.1),
          splashColor: const Color(0xFFB22222).withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.type == NotificationType.document
                        ? Icons.description_outlined
                        : Icons.quiz_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.timestamp,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
