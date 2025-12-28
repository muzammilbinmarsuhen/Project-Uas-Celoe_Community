import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetailPage extends StatelessWidget {
  final Map<String, String> article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article['title'] ?? 'Article Detail',
              style: GoogleFonts.poppins(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
            Text(
              article['url'] ?? 'example.com',
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.open_in_browser, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
         padding: const EdgeInsets.all(24),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Mock Content mimicking a real article view
               Text(
                  article['title'] ?? '',
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, height: 1.3),
               ),
               const SizedBox(height: 16),
               Row(
                  children: [
                     CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 20,
                        child: Text(article['author']?.substring(0, 1) ?? 'A', style: GoogleFonts.poppins(color: Colors.black)),
                     ),
                     const SizedBox(width: 12),
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(article['author'] ?? 'Unknown Author', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                           Text('Published in ${article['year']}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                        ],
                     )
                  ],
               ),
               const SizedBox(height: 32),
               Text(
                  'Abstract',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 8),
               Text(
                  article['snippet'] ?? '',
                  style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[800], height: 1.6),
               ),
               const SizedBox(height: 24),
               Text(
                  'Introduction',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 8),
               Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: GoogleFonts.poppins(fontSize: 16, height: 1.8, color: Colors.black87),
               ),
               const SizedBox(height: 24),
               Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[200],
                  child: Center(child: Text('Image Placeholder', style: GoogleFonts.poppins(color: Colors.grey))),
               ),
               const SizedBox(height: 24),
               Text(
                  'Conclusion',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 8),
               Text(
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
                  style: GoogleFonts.poppins(fontSize: 16, height: 1.8, color: Colors.black87),
               ),
            ],
         ),
      ),
    );
  }
}
