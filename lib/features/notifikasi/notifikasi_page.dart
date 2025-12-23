import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/models/lms_models.dart';
import '../../core/services/api_service.dart';
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
  late Future<List<NotificationItem>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _notificationsFuture = Provider.of<ApiService>(context, listen: false).getNotifications();
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
      body: FutureBuilder<List<NotificationItem>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFA82E2E)));
          }
          
          final notifications = snapshot.data ?? [];
          
          if (notifications.isEmpty) {
             return Center(
               child: Text(
                 'Tidak ada notifikasi',
                 style: GoogleFonts.poppins(color: Colors.grey),
               ),
             );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
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
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: item.isRead ? Colors.white : const Color(0xFFFFF8F8), // Highlight unread
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
            if (item.relatedId != null) {
              if (item.title.toLowerCase().contains('kuis') || (item.relatedType == 'quiz')) {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizIntroPage(quizId: item.relatedId!, title: item.title)),
                 );
              } else if (item.title.toLowerCase().contains('tugas') || (item.relatedType == 'assignment')) {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TugasDetailPage(
                      assignmentId: item.relatedId!, 
                      title: item.title, 
                      deadline: 'Lihat Detail',
                    )),
                 );
              } else {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MateriDetailPage(
                      materialId: item.relatedId!, 
                      title: item.title
                    )),
                 );
              }
            } else {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Detail tidak tersedia')),
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
                    item.title.toLowerCase().contains('kuis') || item.title.toLowerCase().contains('quiz')
                        ? Icons.quiz_outlined 
                        : Icons.description_outlined,
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
                        item.createdAt, // Using createdAt as simpler timestamp string for now
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
