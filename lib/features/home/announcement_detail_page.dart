import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementDetailPage extends StatelessWidget {
  final Map<String, String> announcement;

  const AnnouncementDetailPage({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 0,
         leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
         ),
      ),
      body: SingleChildScrollView(
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Image
               Image.network(
                  announcement['image']!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
               ),
               
               Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        // Badge
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                           decoration: BoxDecoration(
                              color: const Color(0xFFA82E2E),
                              borderRadius: BorderRadius.circular(20),
                           ),
                           child: Text(
                              'PENGUMUMAN',
                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                           ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Title
                        Text(
                           announcement['title']!,
                           style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, height: 1.3),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Date
                        Row(
                           children: [
                              Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 6),
                              Text(
                                 announcement['date']!,
                                 style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 14),
                              ),
                           ],
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 24),
                        
                        // Description
                        Text(
                           announcement['description'] ?? 'Detail pengumuman tidak tersedia.',
                           style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, height: 1.8),
                           textAlign: TextAlign.justify,
                        ),
                        
                        const SizedBox(height: 24),

                        if (announcement['url'] != null)
                           SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                 onPressed: () {
                                     // Open Link
                                     Navigator.pushNamed(
                                         context, 
                                         '/document-viewer',
                                         arguments: {
                                             'title': announcement['title'],
                                             'type': 'link',
                                             'url': announcement['url']
                                         }
                                     );
                                 },
                                 icon: const Icon(Icons.link, size: 18),
                                 label: Text('Baca Selengkapnya', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                                 style: OutlinedButton.styleFrom(
                                     foregroundColor: const Color(0xFFA82E2E),
                                     side: const BorderSide(color: Color(0xFFA82E2E)),
                                     padding: const EdgeInsets.symmetric(vertical: 14),
                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                                 ),
                              ),
                           ),
                        
                        const SizedBox(height: 40),
                     ],
                  ),
               ),
            ],
         ),
      ),
    );
  }
}
