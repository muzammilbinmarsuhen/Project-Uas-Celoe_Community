import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_berita.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
         title: const Text('Informasi & Berita'),
         backgroundColor: Colors.white,
         elevation: 0,
         actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: (){}),
         ],
      ),
      body: ListView.builder(
         padding: const EdgeInsets.all(16),
         itemCount: DummyBerita.list.length,
         itemBuilder: (context, index) {
            final item = DummyBerita.list[index];
            return GestureDetector(
               onTap: () {
                  // Navigate to detail
                  Navigator.pushNamed(context, '/berita-detail', arguments: item);
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
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        ClipRRect(
                           borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                           child: Image.network(
                              item.imageUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx,_,__) => Container(
                                 height: 180, 
                                 color: Colors.grey[300],
                                 child: const Center(child: Icon(Icons.broken_image)),
                              ),
                           ),
                        ),
                        Padding(
                           padding: const EdgeInsets.all(16),
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                    children: [
                                       Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                             color: const Color(0xFFA82E2E).withValues(alpha: 0.1),
                                             borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                             item.category.toUpperCase(),
                                             style: GoogleFonts.poppins(
                                                fontSize: 10, 
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFFA82E2E),
                                             ),
                                          ),
                                       ),
                                       const Spacer(),
                                       Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                                       const SizedBox(width: 4),
                                       Text(
                                          item.date,
                                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                                       ),
                                    ],
                                 ),
                                 const SizedBox(height: 12),
                                 Text(
                                    item.title,
                                    style: GoogleFonts.poppins(
                                       fontSize: 16, 
                                       fontWeight: FontWeight.bold,
                                       color: const Color(0xFF1F2937),
                                    ),
                                 ),
                                 const SizedBox(height: 8),
                                 Text(
                                    item.content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                                 ),
                              ],
                           ),
                        ),
                     ],
                  ),
               ),
            );
         },
      ),
    );
  }
}
