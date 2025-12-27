import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialSlidePage extends StatefulWidget {
  const MaterialSlidePage({super.key});

  @override
  State<MaterialSlidePage> createState() => _MaterialSlidePageState();
}

class _MaterialSlidePageState extends State<MaterialSlidePage> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  // Enriched "AI Recommended" Content Structure
  final List<Map<String, dynamic>> _slides = [
    {
       'title': 'Pengantar UI Design',
       'subtitle': 'Fundamental Interfaces',
       'concept': 'Titik interaksi antara pengguna dan sistem digital.',
       'points': [
          'Fokus pada efisiensi & kemudahan akses.',
          'Melibatkan elemen visual (warna, tipografi).',
          'Bertujuan menciptakan koneksi emosional.'
       ],
       'ai_insight': '💡 AI Tip: UI yang baik tidak terlihat. Pengguna harus bisa mencapai tujuan tanpa berpikir.'
    },
    {
       'title': 'Konsistensi Desain',
       'subtitle': 'Design Systems',
       'concept': 'Keseragaman elemen visual di seluruh bagian aplikasi.',
       'points': [
          'Gunakan palet warna yang terbatas.',
          'Pertahankan hierarki tipografi yang jelas.',
          'Samakan style tombol dan input.'
       ],
       'ai_insight': '💡 AI Tip: Inkonsistensi meningkatkan beban kognitif pengguna hingga 40%.'
    },
    {
       'title': 'Responsiveness',
       'subtitle': 'Multi-device Support',
       'concept': 'Adaptasi tampilan layout pada berbagai ukuran layar.',
       'points': [
          'Gunakan Grid System fluid.',
          'Perbesar area sentuh untuk mobile.',
          'Susun konten secara vertikal di layar kecil.'
       ],
       'ai_insight': '💡 AI Tip: Mobile-first approach lebih efisien daripada desktop-first.'
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Softer background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
        centerTitle: true,
        title: Text('${_currentPage + 1} / ${_slides.length}', style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: Column(
         children: [
            Expanded(
               child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                     // Scale animation for focus effect
                     return AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: _currentPage == index ? 1.0 : 0.9,
                        child: _buildSlideCard(_slides[index], index),
                     );
                  },
               ),
            ),
            const SizedBox(height: 20),
            // Linear Progress
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
               child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                     value: (_currentPage + 1) / _slides.length,
                     backgroundColor: Colors.grey[300],
                     valueColor: AlwaysStoppedAnimation<Color>((_currentPage + 1) == _slides.length ? Colors.green : const Color(0xFFA82E2E)),
                     minHeight: 6,
                  ),
               ),
            )
         ],
      ),
    );
  }

  Widget _buildSlideCard(Map<String, dynamic> slide, int index) {
     return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(24),
           boxShadow: [
              BoxShadow(
                 color: Colors.black.withValues(alpha: 0.08),
                 blurRadius: 20,
                 offset: const Offset(0, 10),
              )
           ],
        ),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              // Header
              Text(slide['subtitle'], style: GoogleFonts.poppins(color: const Color(0xFFA82E2E), fontWeight: FontWeight.w600, letterSpacing: 1.2)),
              const SizedBox(height: 8),
              Text(slide['title'], style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
              
              const SizedBox(height: 30),
              
              // Concept Box
              Container(
                 padding: const EdgeInsets.all(16),
                 decoration: BoxDecoration(
                    color: const Color(0xFFFFF0F0),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFA82E2E).withValues(alpha: 0.1))
                 ),
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(children: [Icon(Icons.lightbulb_outline, color: const Color(0xFFA82E2E), size: 20), SizedBox(width: 8), Text("Konsep Utama", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFFA82E2E)))]),
                       const SizedBox(height: 8),
                       Text(slide['concept'], style: GoogleFonts.poppins(fontSize: 14)),
                    ],
                 ),
              ),

              const SizedBox(height: 24),
              
              // Points
              Text("Penerapan:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 12),
              ...((slide['points'] as List).asMap().entries.map((entry) {
                 return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Container(
                             margin: const EdgeInsets.only(top: 6),
                             width: 6, height: 6,
                             decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(entry.value, style: GoogleFonts.poppins(fontSize: 14, height: 1.5))),
                       ],
                    ),
                 );
              })),

              const Spacer(),
              
              // AI Insight Footer
              Container(
                 width: double.infinity,
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.purple[800]!]),
                    borderRadius: BorderRadius.circular(12),
                 ),
                 child: Text(
                    slide['ai_insight'],
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                 ),
              )
           ],
        ),
     );
  }
}
