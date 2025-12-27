import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/dummy_course_data.dart';
import '../../../../routes/app_routes.dart';

class MaterialTab extends StatelessWidget {
  const MaterialTab({super.key});

  @override
  Widget build(BuildContext context) {
    final materials = DummyCourseData.materials;

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        return _buildMaterialCard(context, materials[index], index);
      },
    );
  }

  Widget _buildMaterialCard(BuildContext context, MaterialItem item, int index) {
    // Staggered Animation
    return TweenAnimationBuilder<double>(
       tween: Tween(begin: 0.0, end: 1.0),
       duration: Duration(milliseconds: 400 + (index * 100)), // Staggered delay logic
       curve: Curves.easeOutQuad,
       builder: (context, value, child) {
          return Transform.translate(
             offset: Offset(0, 50 * (1 - value)), // Slide Up
             child: Opacity(
                opacity: value,
                child: child,
             ),
          );
       },
       child: _ScaleableCard(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.materialDetail, arguments: item);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Illustration Placeholder
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // Using a visual placeholder instead of asset for dummy
                        child: Center(
                           child: Icon(Icons.menu_book, color: Colors.blue, size: 30),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item.meetingTitle,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.title,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.subtitle,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Status Icon
                      Container(
                         margin: const EdgeInsets.only(left: 8),
                         child: Icon(
                           item.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                           color: item.isCompleted ? Colors.green : Colors.grey[300],
                           size: 24,
                         ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
       ),
    );
  }
}

class _ScaleableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _ScaleableCard({required this.child, required this.onTap});
  @override
  State<_ScaleableCard> createState() => _ScaleableCardState();
}

class _ScaleableCardState extends State<_ScaleableCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
     super.initState();
     _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
     _scaleAnimation = Tween(begin: 1.0, end: 0.98).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTapDown: (_) => _controller.forward(),
       onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
       },
       onTapCancel: () => _controller.reverse(),
       child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.scale(scale: _scaleAnimation.value, child: widget.child),
       ),
    );
  }
}
