import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/models.dart';

class ProgramDetailPage extends StatelessWidget {
  final Course course;

  const ProgramDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Hero Image Background
          Positioned(
            top: 0, left: 0, right: 0,
            height: 300,
            child: Image.network(
              course.thumbnail ?? 'https://via.placeholder.com/800x600',
              fit: BoxFit.cover,
              errorBuilder: (_,__,___) => Container(color: Colors.grey[800]),
            ),
          ),
          
          // Gradient Overlay
          Positioned(
             top: 0, left: 0, right: 0, height: 300,
             child: Container(
                decoration: BoxDecoration(
                   gradient: LinearGradient(
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      colors: [Colors.black.withValues(alpha: 0.3), Colors.black.withValues(alpha: 0.7)]
                   )
                ),
             ),
          ),

          // 2. Main Content (Scrollable Sheet)
          Positioned.fill(
             top: 250, 
             child: Container(
                decoration: const BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20)]
                ),
                child: SingleChildScrollView(
                   padding: const EdgeInsets.fromLTRB(24, 30, 24, 100),
                   child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         // Category Badge
                         Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                               color: const Color(0xFFA82E2E).withValues(alpha: 0.1),
                               borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                               course.category,
                               style: GoogleFonts.poppins(color: const Color(0xFFA82E2E), fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                         ),
                         const SizedBox(height: 12),
                         
                         // Title
                         Text(
                            course.title,
                            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2),
                         ),
                         
                         const SizedBox(height: 16),
                         
                         // Instructor / Semester Info
                         Row(
                            children: [
                               const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage('https://i.pravatar.cc/100?u=instructor'), 
                               ),
                               const SizedBox(width: 10),
                               Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(course.instructor, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                                     Text(course.semester, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                                  ],
                               )
                            ],
                         ),
                         
                         const SizedBox(height: 32),
                         const Divider(),
                         const SizedBox(height: 24),

                         // Description
                         Text("Tentang Program", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                         const SizedBox(height: 12),
                         Text(
                            course.description,
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, height: 1.6),
                            textAlign: TextAlign.justify,
                         ),

                         const SizedBox(height: 24),

                         // Program Details Boxes
                         Row(
                            children: [
                               Expanded(child: _buildInfoCard(Icons.access_time_filled, 'Durasi', '4 Minggu')),
                               const SizedBox(width: 16),
                               Expanded(child: _buildInfoCard(Icons.people_alt, 'Peserta', '250+ Org')),
                            ],
                         ),
                         const SizedBox(height: 16),
                         Row(
                            children: [
                               Expanded(child: _buildInfoCard(Icons.language, 'Bahasa', 'Indonesia')),
                               const SizedBox(width: 16),
                               Expanded(child: _buildInfoCard(Icons.verified, 'Sertifikat', 'Ya')),
                            ],
                         ),
                      ],
                   ),
                ),
             ),
          ),

          // 3. Bottom Action Bar
          Positioned(
             bottom: 0, left: 0, right: 0,
             child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: const BoxDecoration(
                   color: Colors.white,
                   border: Border(top: BorderSide(color: Colors.black12))
                ),
                child: ElevatedButton(
                   onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text('Anda telah mendaftar ke program ini!'))
                      );
                   },
                   style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA82E2E), // Maroon
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                   ),
                   child: Text(
                      'Daftar Sekarang (Gratis)',
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                   ),
                ),
             ),
          ),

          // Back Button
          Positioned(
             top: 50, left: 20,
             child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.9),
                child: IconButton(
                   icon: const Icon(Icons.arrow_back, color: Colors.black87),
                   onPressed: () => Navigator.pop(context),
                ),
             ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
           color: const Color(0xFFF9FAFB),
           borderRadius: BorderRadius.circular(12),
           border: Border.all(color: Colors.grey[200]!)
        ),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Icon(icon, color: Colors.grey[600], size: 20),
              const SizedBox(height: 8),
              Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
              Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
           ],
        ),
     );
  }
}
