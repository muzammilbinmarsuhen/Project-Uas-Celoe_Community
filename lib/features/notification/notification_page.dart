import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/data/dummy_data.dart'; // Dummy Data


class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // Use Dummy Data directly
  final List<Map<String, dynamic>> _notifications = DummyData.notifications;

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
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.of(context).pop(), 
        // ), // No back button needed if it's a main tab
        automaticallyImplyLeading: false, 
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
      body: _notifications.isEmpty
          ? Center(
               child: Text(
                 'Tidak ada notifikasi',
                 style: GoogleFonts.poppins(color: Colors.grey),
               ),
            )
          : ListView.builder(
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

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final title = item['title'] as String;
    final body = item['body'] as String;
    final date = item['date'] as String;
    final isRead = item['isRead'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : const Color(0xFFFFF8F8), // Highlight unread
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
             // Mock Navigation based on title string (Simple logic for now)
             if (title.contains('Redesign')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Detail tugas akan segera hadir')),
                 );
             } else {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Detail notifikasi')),
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
                    title.toLowerCase().contains('kuis') || title.toLowerCase().contains('quiz')
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
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        body,
                         style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        date, 
                        style: GoogleFonts.poppins(
                          fontSize: 11,
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
