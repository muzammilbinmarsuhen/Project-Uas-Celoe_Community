import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementCarouselWidget extends StatefulWidget {
  const AnnouncementCarouselWidget({super.key});

  @override
  State<AnnouncementCarouselWidget> createState() => _AnnouncementCarouselWidgetState();
}

class _AnnouncementCarouselWidgetState extends State<AnnouncementCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Mock Data for Carousel
  final List<Map<String, String>> _announcements = [
    {
      'title': 'Maintenance Pra UAS Semester Genap',
      'image': 'https://images.unsplash.com/photo-1531403009284-440f080d1e12?auto=format&fit=crop&w=800&q=80',
      'date': '10 Jan 2025',
      'url': 'https://celoe.telkomuniversity.ac.id/maintenance',
      'description': 'Diberitahukan kepada seluruh mahasiswa bahwa akan dilakukan pemeliharaan sistem (maintenance) untuk persiapan Ujian Akhir Semester (UAS) Genap. Selama periode ini, layanan LMS mungkin akan mengalami gangguan sementara. \n\nMohon untuk menyelesaikan pengumpulan tugas sebelum jadwal maintenance dimulai. Terima kasih atas pengertiannya.'
    },
    {
       'title': 'Webinar: UI/UX Trends 2025',
       'image': 'https://images.unsplash.com/photo-1552664730-d307ca884978?auto=format&fit=crop&w=800&q=80',
       'date': '15 Jan 2025',
       'url': 'https://celoe.telkomuniversity.ac.id/webinar-uiux',
       'description': 'Bergabunglah dalam sesi webinar eksklusif bersama para ahli industri yang akan membahas tren desain antarmuka dan pengalaman pengguna yang diprediksi akan mendominasi di tahun 2025. \n\nTopik meliputi: AI dalam desain, Neumorphism v2, dan aksesibilitas tingkat lanjut.'
    },
    {
       'title': 'Libur Semester Ganjil Dimulai',
       'image': 'https://images.unsplash.com/photo-1455849318743-b2233052fcff?auto=format&fit=crop&w=800&q=80',
       'date': '20 Jan 2025',
       'url': 'https://celoe.telkomuniversity.ac.id/kalender-akademik',
       'description': 'Selamat menikmati libur semester! Perkuliahan semester genap akan dimulai kembali pada tanggal 10 Februari 2025. Gunakan waktu ini untuk beristirahat dan mengembangkan soft skill Anda.'
    }
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _announcements.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180, // Height of the card
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _announcements.length,
            itemBuilder: (context, index) {
              final item = _announcements[index];
              return _buildCarouselItem(item);
            },
          ),
        ),
        const SizedBox(height: 12),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _announcements.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: _currentPage == index ? 20 : 6,
              decoration: BoxDecoration(
                color: _currentPage == index 
                    ? const Color(0xFFA82E2E) // Active Red
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(Map<String, String> item) {
    return GestureDetector(
       onTap: () {
          Navigator.pushNamed(context, '/announcement-detail', arguments: item);
       },
       child: Container(
         margin: const EdgeInsets.symmetric(horizontal: 5), // Spacing between items if viewportFraction < 1
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(16),
           boxShadow: [
             BoxShadow(
               color: Colors.black.withValues(alpha: 0.1),
               blurRadius: 10,
               offset: const Offset(0, 5),
             ),
           ],
           image: DecorationImage(
             image: NetworkImage(item['image']!),
             fit: BoxFit.cover,
             colorFilter: ColorFilter.mode(
               Colors.black.withValues(alpha: 0.3), // Darken image for text readability
               BlendMode.darken, 
             ),
           ),
         ),
         child: Stack(
           children: [
             Positioned(
               bottom: 16,
               left: 16,
               right: 16,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                     decoration: BoxDecoration(
                       color: const Color(0xFFA82E2E),
                       borderRadius: BorderRadius.circular(6),
                     ),
                     child: Text(
                       'PENGUMUMAN',
                       style: GoogleFonts.poppins(
                         color: Colors.white,
                         fontSize: 10,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                   const SizedBox(height: 8),
                   Text(
                     item['title']!,
                     style: GoogleFonts.poppins(
                       color: Colors.white,
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                       shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                           )
                       ],
                     ),
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                   ),
                   const SizedBox(height: 4),
                   Row(
                     children: [
                       const Icon(Icons.calendar_today, color: Colors.white70, size: 12),
                       const SizedBox(width: 4),
                       Text(
                         item['date']!,
                         style: GoogleFonts.poppins(
                           color: Colors.white70,
                           fontSize: 12,
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
    );
  }
}
