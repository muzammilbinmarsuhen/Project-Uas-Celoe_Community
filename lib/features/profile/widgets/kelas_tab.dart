import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models.dart';

class KelasTab extends StatelessWidget {
  final List<ClassModel> classes;

  const KelasTab({super.key, required this.classes});

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
       return Center(child: Text('Belum ada kelas diambil', style: GoogleFonts.poppins(color: Colors.grey)));
    }
    
    return ListView.builder(
       padding: const EdgeInsets.all(20),
       itemCount: classes.length,
       itemBuilder: (context, index) {
         final item = classes[index];
         // Dynamic Icon Logic
         IconData iconData = Icons.book;
         Color iconColor = Colors.blue;
         
         final nameLower = item.namaKelas.toLowerCase();
         if (nameLower.contains('desain') || nameLower.contains('ui/ux')) {
           iconData = Icons.brush;
           iconColor = Colors.purple;
         } else if (nameLower.contains('mobile') || nameLower.contains('flutter')) {
           iconData = Icons.phone_android;
           iconColor = Colors.green;
         } else if (nameLower.contains('web')) {
           iconData = Icons.language;
           iconColor = Colors.blue;
         } else if (nameLower.contains('data') || nameLower.contains('algo')) {
           iconData = Icons.storage;
           iconColor = Colors.orange;
         }

         return TweenAnimationBuilder<double>(
           tween: Tween(begin: 0.0, end: 1.0),
           duration: Duration(milliseconds: 400 + (index * 100)),
           curve: Curves.easeOut,
           builder: (context, value, child) {
             return Transform.translate(
               offset: Offset(0, 50 * (1 - value)),
               child: Opacity(
                 opacity: value,
                 child: child,
               ),
             );
           },
           child: GestureDetector(
             onTap: () {
                Navigator.pushNamed(context, '/course-menu');
             },
             child: Container(
             margin: const EdgeInsets.only(bottom: 16),
             padding: const EdgeInsets.all(16),
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
             child: Row(
               children: [
                 Container(
                   width: 50, height: 50,
                   decoration: BoxDecoration(
                     color: iconColor.withValues(alpha: 0.1),
                     borderRadius: BorderRadius.circular(12),
                   ),
                   child: Icon(iconData, color: iconColor, size: 24),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         item.namaKelas,
                         style: GoogleFonts.poppins(
                           fontWeight: FontWeight.w600,
                           fontSize: 15,
                           color: Colors.black87,
                         ),
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                       ),
                       const SizedBox(height: 4),
                       Text(
                         '${item.kodeKelas} • ${item.dosen}', 
                         style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                       ),
                       const SizedBox(height: 4),
                       Text(
                         'Mulai: ${_formatDate(item.tanggalMulai)}', 
                         style: GoogleFonts.poppins(color: iconColor, fontSize: 11, fontWeight: FontWeight.w500),
                       ),
                     ],
                   ),
                 ),
                 const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
               ],
             ),
           ),
          ),
         );
       },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
