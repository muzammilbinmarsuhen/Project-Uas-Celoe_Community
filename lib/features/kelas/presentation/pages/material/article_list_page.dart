import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for Articles
    final List<Map<String, String>> articles = [
      {
        'title': 'The Principles of User Interface Design',
        'author': 'J. Nielsen',
        'year': '2023',
        'snippet': 'This paper discusses the fundamental heuristics of user interface design, focusing on usability and efficiency...',
        'url': 'https://example.com/article1',
      },
      {
        'title': 'Mobile First: A Strategy for Design',
        'author': 'L. Wroblewski',
        'year': '2022',
        'snippet': 'Exploring the shift towards mobile-first design strategies and their impact on responsive web development...',
        'url': 'https://example.com/article2',
      },
      {
        'title': 'Color Theory in Digital Media',
        'author': 'M. Oscura',
        'year': '2024',
        'snippet': 'An in-depth analysis of how color perception affects user engagement and conversion rates in digital products...',
        'url': 'https://example.com/article3',
      },
      {
        'title': 'Accessibility Guidelines for Modern UI',
        'author': 'W3C Consortium',
        'year': '2023',
        'snippet': 'A comprehensive guide to WCAG 2.1 compliance and ensuring digital inclusivity for all users...',
        'url': 'https://example.com/article4',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Referensi Artikel",
          style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[200], height: 1.0),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const Divider(height: 32, color: Color(0xFFEEEEEE)),
        itemBuilder: (context, index) {
          final article = articles[index];
          return InkWell(
            onTap: () {
               Navigator.pushNamed(
                 context, 
                 '/article-detail',
                 arguments: article,
               );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: const Color(0xFF1A0DAB), // Google Link Color
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.green[800]),
                    children: [
                      TextSpan(text: article['author']),
                      const TextSpan(text: ' - '),
                      TextSpan(text: article['year']),
                      const TextSpan(text: ' - example.com'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article['snippet']!,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_border, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('Simpan', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                    const SizedBox(width: 16),
                    const Icon(Icons.format_quote, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('Kutip', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
