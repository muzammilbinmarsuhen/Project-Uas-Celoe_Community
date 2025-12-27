import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialSlidePage extends StatefulWidget {
  const MaterialSlidePage({super.key});

  @override
  State<MaterialSlidePage> createState() => _MaterialSlidePageState();
}

class _MaterialSlidePageState extends State<MaterialSlidePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _slides = [
    {
       'title': 'Pengantar UI Design',
       'subtitle': 'CHAPTER 01',
       'bg_colors': [Color(0xFF1A2980), Color(0xFF26D0CE)], // Deep Blue -> Aqua
       'icon': Icons.design_services_outlined,
       'concept': 'UI Design adalah jembatan visual antara manusia dan teknologi. Fokus utamanya adalah kejelasan dan efisiensi.',
       'points': [
          'Visual Hierarchy (Hierarki Visual)',
          'Consistency (Konsistensi)',
          'Accessibility (Aksesibilitas)',
          'Feedback Pengguna'
       ],
       'ai_insight': '🤖 AI Note: 94% kesan pertama pengguna terhadap produk digital ditentukan oleh desain visualnya.'
    },
    {
       'title': 'Warna & Psikologi',
       'subtitle': 'CHAPTER 02',
       'bg_colors': [Color(0xFFEB3349), Color(0xFFF45C43)], // Red -> Orange
       'icon': Icons.palette_outlined,
       'concept': 'Warna bukan sekadar estetika, tapi alat komunikasi bawah sadar yang memicu emosi dan tindakan.',
       'points': [
          '60-30-10 Rule dalam pewarnaan',
          'Warna Primer vs Sekunder',
          'Kontras untuk Readability',
          'Dark Mode Optimization'
       ],
       'ai_insight': '🤖 AI Note: Warna biru meningkatkan kepercayaan, sementara merah memicu urgensi.'
    },
    {
       'title': 'Tipografi Modern',
       'subtitle': 'CHAPTER 03',
       'bg_colors': [Color(0xFF4B79A1), Color(0xFF283E51)], // Dark Blue -> Black
       'icon': Icons.text_fields_outlined,
       'concept': 'Tipografi yang baik membuat konten mudah dipindai (scannable) dan nyaman dibaca dalam jangka waktu lama.',
       'points': [
          'Pemilihan Font (Serif vs Sans)',
          'Line Height & Letter Spacing',
          'Font Scale (Modular Scale)',
          'Responsive Typography'
       ],
       'ai_insight': '🤖 AI Note: Gunakan maksimal 2 jenis font dalam satu aplikasi untuk menjaga kebersihan visual.'
    },
    {
       'title': 'Layout & Grid',
       'subtitle': 'CHAPTER 04',
       'bg_colors': [Color(0xFF00B4DB), Color(0xFF0083B0)], // Cyan -> Blue
       'icon': Icons.grid_view,
       'concept': 'Grid system menciptakan ritme dan keteraturan, memudahkan user memproses informasi yang kompleks.',
       'points': [
          '8px Grid System',
          'Fluid Containers',
          'White Space (Ruang Negatif)',
          'Responsive Breakpoints'
       ],
       'ai_insight': '🤖 AI Note: White space bukan ruang kosong, melainkan elemen desain yang aktif.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
           Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                 color: Colors.white.withValues(alpha: 0.2),
                 borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                 '${_currentPage + 1}/${_slides.length}',
                 style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
              ),
           )
        ],
        elevation: 0,
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical, // Vertical Scroll (Slide ke Bawah)
        itemCount: _slides.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
           return _VerticalSlideItem(
              slide: _slides[index],
              isActive: _currentPage == index,
           );
        },
      ),
    );
  }
}

class _VerticalSlideItem extends StatefulWidget {
  final Map<String, dynamic> slide;
  final bool isActive;

  const _VerticalSlideItem({required this.slide, required this.isActive});

  @override
  State<_VerticalSlideItem> createState() => _VerticalSlideItemState();
}

class _VerticalSlideItemState extends State<_VerticalSlideItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    if (widget.isActive) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _VerticalSlideItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward(from: 0.0);
    } else if (!widget.isActive && oldWidget.isActive) {
       _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedContent(Widget child, double start, double end, {Offset beginOffset = const Offset(0, 0.3)}) {
     return FadeTransition(
        opacity: CurvedAnimation(
           parent: _controller,
           curve: Interval(start, end, curve: Curves.easeOut),
        ),
        child: SlideTransition(
           position: Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
              CurvedAnimation(
                 parent: _controller,
                 curve: Interval(start, end, curve: Curves.easeOutQuart),
              )
           ),
           child: child,
        ),
     );
  }

  @override
  Widget build(BuildContext context) {
    List<Color> bgColors = widget.slide['bg_colors'];
    
    return Container(
       decoration: BoxDecoration(
          gradient: LinearGradient(
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
             colors: bgColors,
          )
       ),
       child: Stack(
          children: [
             // Organic Background Shapes (Decoration)
             Positioned(
                top: -50, right: -50,
                child: _buildAnimatedContent(
                   Container(width: 200, height: 200, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle)),
                   0.0, 0.5, beginOffset: const Offset(0.2, -0.2)
                ),
             ),
             Positioned(
                bottom: 100, left: -30,
                child: _buildAnimatedContent(
                   Container(width: 150, height: 150, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), shape: BoxShape.circle)),
                   0.2, 0.7, beginOffset: const Offset(-0.2, 0.2)
                ),
             ),

             // Main Content
             SafeArea(
                child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                   child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const SizedBox(height: 20),
                         
                         // Subtitle
                         _buildAnimatedContent(
                            Text(widget.slide['subtitle'], style: GoogleFonts.poppins(color: Colors.white70, letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 14)),
                            0.1, 0.4
                         ),
                         
                         // Title
                         _buildAnimatedContent(
                            Text(widget.slide['title'], style: GoogleFonts.poppins(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800, height: 1.1)),
                            0.2, 0.5
                         ),

                         const SizedBox(height: 30),

                         // Concept Card (Glassmorphism)
                         _buildAnimatedContent(
                            Container(
                               padding: const EdgeInsets.all(20),
                               decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]
                               ),
                               child: Column(
                                  children: [
                                     Icon(widget.slide['icon'], color: Colors.white, size: 40),
                                     const SizedBox(height: 16),
                                     Text(
                                        widget.slide['concept'],
                                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, height: 1.5),
                                        textAlign: TextAlign.center,
                                     )
                                  ],
                               )
                            ),
                            0.3, 0.6, beginOffset: const Offset(0, 0.1)
                         ),

                         const SizedBox(height: 30),

                         // Bullet Points
                         Expanded(
                            child: ListView.builder(
                               padding: EdgeInsets.zero,
                               physics: const NeverScrollableScrollPhysics(),
                               itemCount: (widget.slide['points'] as List).length,
                               itemBuilder: (context, idx) {
                                  double st = 0.5 + (idx * 0.1);
                                  return _buildAnimatedContent(
                                     Container(
                                        margin: const EdgeInsets.only(bottom: 16),
                                        child: Row(
                                           children: [
                                              Container(
                                                 padding: const EdgeInsets.all(6),
                                                 decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                 child: Icon(Icons.check, size: 14, color: bgColors[0]),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                 child: Text(
                                                    widget.slide['points'][idx],
                                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                 ),
                                              )
                                           ],
                                        )
                                     ),
                                     st, st + 0.3, beginOffset: const Offset(0.1, 0.0)
                                  );
                               }
                            ),
                         ),

                         // AI Footer
                         _buildAnimatedContent(
                            Container(
                               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                               decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(16),
                               ),
                               child: Row(
                                  children: [
                                     const SizedBox(width: 8),
                                     Expanded(
                                        child: Text(
                                           widget.slide['ai_insight'],
                                           style: GoogleFonts.poppins(color: Colors.white.withValues(alpha: 0.9), fontSize: 13, fontStyle: FontStyle.italic),
                                        ),
                                     )
                                  ],
                               )
                            ),
                            0.8, 1.0, beginOffset: const Offset(0, 0.1)
                         ),
                         const SizedBox(height: 20),
                         
                         // Scroll Indicator
                         Center(
                            child: _buildAnimatedContent(
                               Column(
                                  children: [
                                     Text("Scroll Down", style: GoogleFonts.poppins(color: Colors.white54, fontSize: 10)),
                                     const Icon(Icons.keyboard_arrow_down, color: Colors.white54)
                                  ],
                               ),
                               0.9, 1.0
                            )
                         )
                      ],
                   ),
                ),
             )
          ],
       ),
    );
  }
}
