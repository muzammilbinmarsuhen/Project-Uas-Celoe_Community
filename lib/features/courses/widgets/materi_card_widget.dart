import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MateriCardWidget extends StatelessWidget {
  final int index;
  final String title;
  final String subtext;
  final bool isCompleted;
  final VoidCallback? onTap;
  final Animation<double>? animation;

  const MateriCardWidget({
    super.key,
    required this.index,
    required this.title,
    required this.subtext,
    required this.isCompleted,
    this.onTap,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Row: Badge and Check Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5686E1), // Design Blue
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Pertemuan ${index + 1}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: isCompleted ? const Color(0xFF4CAF50) : Colors.grey[300],
                      size: 24,
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),

                // 2. Content: Title
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                
                const SizedBox(height: 8),

                // 3. Subtitle / Meta
                Text(
                  subtext,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (animation != null) {
      return FadeTransition(
        opacity: animation!,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(animation!),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
