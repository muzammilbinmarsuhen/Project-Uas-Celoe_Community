import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TugasKuisCardWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Animation<double>? animation;
  final VoidCallback? onTap;

  const TugasKuisCardWidget({
    super.key,
    required this.item,
    this.animation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Extract data
    final String type = item['type'] ?? 'Tugas';
    final String title = item['title'] ?? '';
    final String deadline = item['deadline'] ?? '';
    final bool isCompleted = item['isCompleted'] ?? false;
    final bool isQuiz = type.toLowerCase().contains('qui') || type.toLowerCase().contains('kuis');

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
                // 1. Top Row: Badge & Check
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: type == 'Tugas' ? const Color(0xFF5686E1) : const Color(0xFF5686E1).withValues(alpha: 0.8), 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                         // If type contains 'Quiz' or 'Kuis', display 'QUIZ', else 'Tugas'
                         isQuiz ? 'QUIZ' : 'Tugas',
                         style: GoogleFonts.poppins(
                           color: Colors.white,
                           fontSize: 12,
                           fontWeight: FontWeight.bold,
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

                // 2. Middle Row: Icon & Title
                Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     // Big Icon
                     Icon(
                       isQuiz ? Icons.chat_bubble_outline_rounded : Icons.description_outlined,
                       size: 40,
                       color: Colors.black87,
                     ),
                     const SizedBox(width: 16),
                     
                     // Title
                     Expanded(
                        child:  Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                     ),
                   ],
                ),

                const SizedBox(height: 12),

                // 3. Bottom: Deadline Text
                Text(
                  deadline.isNotEmpty ? deadline : 'Tenggat Waktu : -',
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
