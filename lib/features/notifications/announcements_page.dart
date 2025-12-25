import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pengumuman_detail_page.dart';

class PengumumanPage extends StatefulWidget {
  const PengumumanPage({super.key});

  @override
  State<PengumumanPage> createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<AnnouncementItem> _announcements = [
    AnnouncementItem(
      title: 'Maintenance Pra UAS Semester Genap 2020/2021',
      author: 'Admin CeLOE',
      date: '10 Jan 2024 - 08:30',
    ),
    AnnouncementItem(
      title: 'Jadwal Webinar "Effective Learning Strategies"',
      author: 'Academic Support',
      date: '08 Jan 2024 - 14:00',
    ),
    AnnouncementItem(
      title: 'Update Kebijakan Privasi Pengguna',
      author: 'Legal Team',
      date: '05 Jan 2024 - 09:15',
    ),
     AnnouncementItem(
      title: 'Pengumuman Libur Akademik',
      author: 'Admin Universitas',
      date: '01 Jan 2024 - 00:00',
    ),
  ];


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
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
          'Pengumuman',
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
        padding: const EdgeInsets.all(16.0),
        itemCount: _announcements.length,
        itemBuilder: (context, index) {
          final item = _announcements[index];
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
                child: _AnnouncementCard(item: item, index: index),
              ));
        },
      ),
    );
  }
}

class AnnouncementItem {
  final String title;
  final String author;
  final String date;

  AnnouncementItem({
    required this.title,
    required this.author,
    required this.date,
  });
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementItem item;
  final int index;

  const _AnnouncementCard({required this.item, required this.index});

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PengumumanDetailPage(index: index),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0F0), // Light red tint
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.campaign_outlined,
                    color: Color(0xFFB22222), // Maroon
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
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.person_outline,
                              size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            item.author,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.access_time,
                              size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            item.date,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
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
