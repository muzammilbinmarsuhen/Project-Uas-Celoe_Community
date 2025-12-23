import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TugasKuisCardWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Animation<double>? animation;

  const TugasKuisCardWidget({
    super.key,
    required this.item,
    this.animation,
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
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Section
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isQuiz ? const Color(0xFFFFF3E0) : const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isQuiz ? Icons.quiz_outlined : Icons.description_outlined,
                    color: isQuiz ? Colors.orange[800] : Colors.blue[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Content Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isQuiz 
                              ? const Color(0xFFFFF3E0) 
                              : const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isQuiz ? 'Kuis' : 'Tugas',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isQuiz ? Colors.orange[800] : Colors.blue[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                       const SizedBox(height: 8),
                      // Deadline
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Tenggat: $deadline',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[500],
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                 // Check Icon
                const SizedBox(width: 12),
                Icon(
                  Icons.check_circle,
                  color: isCompleted ? const Color(0xFF4CAF50) : Colors.grey[300],
                  size: 24,
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
