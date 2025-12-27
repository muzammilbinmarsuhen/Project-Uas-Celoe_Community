import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models.dart';

class KelasTab extends StatelessWidget {
  final List<ClassModel> classes;

  const KelasTab({super.key, required this.classes});

  @override
  Widget build(BuildContext context) {
     return ListView.builder(
       padding: const EdgeInsets.all(16),
       itemCount: classes.length,
       itemBuilder: (context, index) {
         final item = classes[index];
         // Logic to determine icon based on class name
         IconData iconData = Icons.book;
         Color iconColor = Colors.blue;
         
         if (item.namaKelas.toLowerCase().contains('desain')) {
           iconData = Icons.brush;
           iconColor = Colors.purple;
         } else if (item.namaKelas.toLowerCase().contains('mobile')) {
           iconData = Icons.phone_android;
           iconColor = Colors.green;
         } else if (item.namaKelas.toLowerCase().contains('sistem')) {
            iconData = Icons.computer;
            iconColor = Colors.orange;
         }


         return Container(
           margin: const EdgeInsets.only(bottom: 16),
           padding: const EdgeInsets.all(16),
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(12),
             boxShadow: const [
               BoxShadow(
                 color: Color.fromRGBO(0, 0, 0, 0.05),
                 blurRadius: 10,
                 offset: Offset(0, 4),
               ),
             ],
           ),
           child: Row(
             children: [
               Container(
                 width: 50, height: 50,
                 decoration: BoxDecoration(
                   color: iconColor.withValues(alpha: 0.1),
                   borderRadius: BorderRadius.circular(25),
                 ),
                 child: Icon(iconData, color: iconColor),
               ),
               const SizedBox(width: 16),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       item.namaKelas,
                       style: GoogleFonts.poppins(
                         fontWeight: FontWeight.bold,
                         fontSize: 14,
                       ),
                     ),
                     const SizedBox(height: 4),
                     Text('${item.kodeKelas} [${item.dosen}]', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                     const SizedBox(height: 4),
                     Text('Dimulai ${item.tanggalMulai.toLocal().toString().split(' ')[0]}', style: GoogleFonts.poppins(color: Colors.orange, fontSize: 12)),
                   ],
                 ),
               ),
             ],
           ),
         );
       },
     );
  }
}
