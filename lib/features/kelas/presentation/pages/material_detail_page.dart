import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/dummy_course_data.dart';

class MaterialDetailPage extends StatefulWidget {
  final MaterialItem material;
  const MaterialDetailPage({super.key, required this.material});

  @override
  State<MaterialDetailPage> createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends State<MaterialDetailPage> with SingleTickerProviderStateMixin {
  late TabController _internalTabController;

  @override
  void initState() {
    super.initState();
    _internalTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _internalTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
         backgroundColor: const Color(0xFFA82E2E),
         leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
         ),
         title: Text(
            'Detail Materi',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
         ),
         elevation: 0,
      ),
      body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Container(
               padding: const EdgeInsets.all(20),
               color: Colors.white,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                        widget.material.title,
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 8),
                     Text(
                        widget.material.description,
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
                     ),
                  ],
               ),
            ),
            const SizedBox(height: 10),
            Container(
               color: Colors.white,
               child: TabBar(
                  controller: _internalTabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFFA82E2E), // Maroon
                  tabs: const [
                     Tab(text: 'Lampiran Materi'),
                     Tab(text: 'Tugas dan Kuis'),
                  ],
               ),
            ),
            Expanded(
               child: TabBarView(
                  controller: _internalTabController,
                  children: [
                     _buildAttachmentList(),
                     _buildEmptyTaskState(),
                  ],
               ),
            ),
         ],
      ),
    );
  }

  Widget _buildAttachmentList() {
     if (widget.material.attachments.isEmpty) {
        return Center(child: Text("Tidak ada lampiran", style: GoogleFonts.poppins()));
     }
     
     return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: widget.material.attachments.length,
        itemBuilder: (context, index) {
           final item = widget.material.attachments[index];
           IconData icon = Icons.link;
           Color color = Colors.blue;
           if (item.type == 'pdf') { icon = Icons.picture_as_pdf; color = Colors.red; }
           if (item.type == 'video') { icon = Icons.videocam; color = Colors.purple; }

           // Staggered Entrance
           return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 300 + (index * 100)),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                 return Transform.scale(
                    scale: value,
                    child: Opacity(opacity: value, child: child),
                 );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(50), // Pill Shape
                   border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                   children: [
                      Container(
                         padding: const EdgeInsets.all(8),
                         decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
                         child: Icon(icon, color: color, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                         child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(item.title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                            ],
                         ),
                      ),
                      TweenAnimationBuilder<double>(
                         tween: Tween(begin: 0.0, end: 1.0),
                         duration: const Duration(milliseconds: 600),
                         curve: Curves.elasticOut,
                         builder: (context, val, child) => Transform.scale(scale: val, child: child),
                         child: const Icon(Icons.check_circle, color: Colors.green, size: 20),
                      ),
                   ],
                ),
              ),
           );
        },
     );
  }

  Widget _buildEmptyTaskState() {
     return Center(
        child: _LoopingBounceWidget(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
                Container(
                   height: 120, width: 120,
                   decoration: const BoxDecoration(
                      color: Color(0xFFFFF0F0),
                      shape: BoxShape.circle,
                   ),
                   child: const Icon(Icons.assignment_turned_in, size: 60, color: Color(0xFFA82E2E)),
                ),
                const SizedBox(height: 24),
                Text(
                   'Tidak Ada Tugas Dan Kuis Hari Ini',
                   style: GoogleFonts.poppins(
                      fontSize: 16, 
                      color: Colors.black87, 
                      fontWeight: FontWeight.w600
                   ),
                ),
             ],
           ),
        ),
     );
  }
}

// Top-level class for animation
class _LoopingBounceWidget extends StatefulWidget {
  final Widget child;
  const _LoopingBounceWidget({required this.child});
  @override
  State<_LoopingBounceWidget> createState() => _LoopingBounceWidgetState();
}

class _LoopingBounceWidgetState extends State<_LoopingBounceWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
           offset: Offset(0, -10 * _controller.value), 
           child: child,
        );
      },
      child: widget.child,
    );
  }
}
