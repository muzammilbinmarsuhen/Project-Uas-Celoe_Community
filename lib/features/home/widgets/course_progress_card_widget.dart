import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models.dart';

class CourseProgressCardWidget extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseProgressCardWidget({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
             BoxShadow(
               color: Colors.black.withValues(alpha: 0.03),
               blurRadius: 10,
               offset: const Offset(0, 2),
             ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Thumbnail
             Container(
               width: 70, height: 70,
               decoration: BoxDecoration(
                 color: Colors.grey[200], 
                 borderRadius: BorderRadius.circular(12),
                 image: course.thumbnail != null 
                    ? DecorationImage(image: NetworkImage(course.thumbnail!), fit: BoxFit.cover)
                    : null
               ),
               alignment: Alignment.center,
               child: course.thumbnail == null 
                 ? Text(course.title.substring(0, 1), style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)) 
                 : null,
             ),
             const SizedBox(width: 16),
             
             // Info
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                     decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                     ),
                     child: Text(
                       course.semester,
                       style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 10, fontWeight: FontWeight.w600),
                     ),
                   ),
                   const SizedBox(height: 6),
                   Text(
                     course.title,
                     style: GoogleFonts.poppins(
                       color: Colors.black87,
                       fontSize: 13, 
                       fontWeight: FontWeight.bold,
                       height: 1.3,
                     ),
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                   ),
                   const SizedBox(height: 10),
                   
                   // Animated Progress Bar
                   Row(
                     children: [
                       Expanded(
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(4),
                           child: TweenAnimationBuilder<double>(
                             tween: Tween<double>(begin: 0, end: course.progress / 100),
                             duration: const Duration(seconds: 1),
                             curve: Curves.easeOutQuart,
                             builder: (context, value, child) {
                               return LinearProgressIndicator(
                                 value: value,
                                 minHeight: 6,
                                 backgroundColor: Colors.grey[100],
                                 valueColor: const AlwaysStoppedAnimation(Color(0xFFA82E2E)),
                               );
                             },
                           ),
                         ),
                       ),
                       const SizedBox(width: 12),
                       Text(
                         '${((course.progress)).toInt()}%',
                         style: GoogleFonts.poppins(
                            color: const Color(0xFFA82E2E), 
                            fontSize: 11, 
                            fontWeight: FontWeight.bold
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }
}
