import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/dummy_berita.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = DummyBerita.list;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita & Edukasi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return GestureDetector(
            onTap: () {
               // Use ArticleDetailPage which accepts title and url.
               // Since dummy data might be local content, we might use a different page or just pass a google search url for demo.
               Navigator.pushNamed(
                 context, 
                 '/article-detail',
                 arguments: {
                   'title': item.title,
                   'url': 'https://www.google.com/search?q=${Uri.encodeComponent(item.title)}', // Demo URL
                 }
               );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 20),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   // Image
                   Image.network(
                     item.imageUrl,
                     height: 180,
                     width: double.infinity,
                     fit: BoxFit.cover,
                     errorBuilder: (_,__,___) => Container(
                       height: 180, 
                       color: Colors.grey[200],
                       child: const Icon(Icons.image_not_supported, color: Colors.grey),
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
                                 color: AppTheme.primaryMaroon.withValues(alpha: 0.1),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: Text(
                                 item.category,
                                 style: GoogleFonts.poppins(
                                   fontSize: 10,
                                   fontWeight: FontWeight.bold,
                                   color: AppTheme.primaryMaroon,
                                 ),
                               ),
                             ),
                             const SizedBox(width: 8),
                             Text(
                               item.date,
                               style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                             ),
                           ],
                         ),
                         const SizedBox(height: 12),
                         Text(
                           item.title,
                           style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                         ),
                         const SizedBox(height: 8),
                         Text(
                           item.content,
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                           style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                         ),
                       ],
                     ),
                   )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
