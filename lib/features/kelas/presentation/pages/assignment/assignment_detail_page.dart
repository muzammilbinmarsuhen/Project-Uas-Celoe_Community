import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignmentDetailPage extends StatelessWidget {
  const AssignmentDetailPage({super.key});

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
          'Detail Tugas',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
         padding: const EdgeInsets.all(20),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Animated Card
               TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                     return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                     );
                  },
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(
                           'Tugas 01 - UID Android Mobile Game',
                           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                           children: [
                              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(
                                 'Deadline: 30 Des 2025, 23:59',
                                 style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
                              ),
                           ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Status Card
                        Container(
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.orange.withValues(alpha: 0.3))
                           ),
                           child: Row(
                              children: [
                                 Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                                    child: const Icon(Icons.hourglass_empty, color: Colors.white, size: 20),
                                 ),
                                 const SizedBox(width: 16),
                                 Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text('Status Pengumpulan', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                                       Text('Belum Dikirim', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange[800])),
                                    ],
                                 )
                              ],
                           ),
                        ),
                        const SizedBox(height: 24),

                        Text('Deskripsi Tugas', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text(
                           'Buatlah low-fidelity wireframe untuk aplikasi mobile game sederhana berbasis Android. Pastikan mencakup halaman menu utama, gameplay, dan settings.',
                           style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800], height: 1.6),
                        ),
                        const SizedBox(height: 24),
                        
                        Text('Ketentuan Pengerjaan', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                         _buildBulletPoint('Format file: PDF atau Figma Link'),
                         _buildBulletPoint('Ukuran maksimal: 5MB'),
                         _buildBulletPoint('Gunakan template yang sudah disediakan'),

                        const SizedBox(height: 40),
                        
                        SizedBox(
                           width: double.infinity,
                           child: ElevatedButton.icon(
                              onPressed: () {
                                 Navigator.pushNamed(context, '/upload-file');
                              }, 
                              icon: const Icon(Icons.upload_file, color: Colors.white),
                              label: Text('Tambahkan Tugas', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                 backgroundColor: const Color(0xFFA82E2E),
                                 padding: const EdgeInsets.symmetric(vertical: 16),
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                 elevation: 4
                              ),
                           ),
                        )
                     ],
                  ),
               )
            ],
         ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
     return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Padding(
                 padding: EdgeInsets.only(top: 6),
                 child: Icon(Icons.circle, size: 6, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]))),
           ],
        ),
     );
  }
}
