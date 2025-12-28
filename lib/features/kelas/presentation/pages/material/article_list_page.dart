import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String pageTitle = args?['title'] ?? "Referensi Artikel";

    // Dummy Data for Articles with PDF/Doc links to mimic Google Scholar results
    final List<Map<String, String>> articles = [
      {
        'title': 'The Principles of User Interface Design',
        'author': 'J. Nielsen',
        'year': '2023',
        'source': 'nngroup.com',
        'snippet': 'This paper discusses the fundamental heuristics of user interface design, focusing on usability and efficiency. It covers 10 general principles for interaction design...',
        'url': 'https://en.wikipedia.org/wiki/User_interface_design',
        'pdfUrl': 'https://pdfobject.com/pdf/sample.pdf', 
        'docUrl': 'https://filesamples.com/samples/document/doc/sample2.doc',
      },
      {
        'title': 'Mobile First: A Strategy for Design',
        'author': 'L. Wroblewski',
        'year': '2022',
        'source': 'uxdesign.cc',
        'snippet': 'Exploring the shift towards mobile-first design strategies and their impact on responsive web development. The mobile-first approach is not just about screen size...',
        'url': 'https://en.wikipedia.org/wiki/Responsive_web_design',
        'pdfUrl': 'https://pdfobject.com/pdf/sample.pdf',
      },
      {
        'title': 'Color Theory in Digital Media',
        'author': 'M. Oscura',
        'year': '2024',
        'source': 'color-research.org',
        'snippet': 'An in-depth analysis of how color perception affects user engagement and conversion rates in digital products. Understanding color psychology is crucial for...',
        'url': 'https://en.wikipedia.org/wiki/Color_theory',
        'docUrl': 'https://filesamples.com/samples/document/doc/sample2.doc',
      },
      {
        'title': 'Accessibility Guidelines for Modern UI',
        'author': 'W3C Consortium',
        'year': '2023',
        'source': 'w3.org',
        'snippet': 'A comprehensive guide to WCAG 2.1 compliance and ensuring digital inclusivity for all users. This standard covers success criteria for web content accessibility...',
        'url': 'https://www.w3.org/WAI/standards-guidelines/wcag/',
        'pdfUrl': 'https://pdfobject.com/pdf/sample.pdf',
      },
      {
        'title': 'Understanding Flutter Architecture',
        'author': 'Google',
        'year': '2023',
        'source': 'flutter.dev',
        'snippet': 'Flutter uses an aggressive composition model. Widgets are the basic building blocks of a Flutter app user interface. Each widget is an immutable declaration of part of the user interface.',
        'url': 'https://docs.flutter.dev/resources/architectural-overview',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          pageTitle,
          style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 1, // Slight elevation like mobile browser
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const Divider(height: 30, color: Color(0xFFEEEEEE), thickness: 1),
        itemBuilder: (context, index) {
          final article = articles[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Title Link
               InkWell(
                  onTap: () {
                     // Navigate to Document Viewer (WebView) for the main link
                     Navigator.pushNamed(context, '/document-viewer', arguments: {
                        'title': article['title'],
                        'type': 'link', // Treat as web link
                        'url': article['url']
                     });
                  },
                  child: Text(
                    article['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: const Color(0xFF1A0DAB), // Google Blue
                      height: 1.2,
                    ),
                  ),
               ),
               const SizedBox(height: 4),
               
               // Metadata (Author - Year - Source)
               RichText(
                 text: TextSpan(
                   style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF006621)), // Google Green
                   children: [
                     TextSpan(text: article['author']),
                     const TextSpan(text: ' - '),
                     TextSpan(text: article['year']),
                     const TextSpan(text: ' - '),
                     TextSpan(text: article['source'], style: const TextStyle(fontWeight: FontWeight.bold)),
                   ],
                 ),
               ),
               const SizedBox(height: 6),

               // Snippet
               Text(
                 article['snippet']!,
                 style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF545454), height: 1.4), // Google Grey
                 maxLines: 4,
                 overflow: TextOverflow.ellipsis,
               ),
               const SizedBox(height: 10),

               // Action Row (PDF/DOC and fake citations)
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   // PDF Link
                   if (article.containsKey('pdfUrl'))
                     _buildFileLink(context, '[PDF] ${article['source']}', article['pdfUrl']!, 'pdf', article['title']!),
                   
                   // DOC Link
                   if (article.containsKey('docUrl'))
                     _buildFileLink(context, '[DOC] ${article['source']}', article['docUrl']!, 'doc', article['title']!),

                   const SizedBox(width: 8),
                   if (article.containsKey('pdfUrl') || article.containsKey('docUrl'))
                      const SizedBox(width: 8), // Spacer between file links and citations

                   // Fake Citation Links
                   Text('Dirujuk 52 kali', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF545454))),
                   const SizedBox(width: 12),
                   Text('Artikel terkait', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF545454))),
                 ],
               )
            ],
          );
        },
      ),
    );
  }

  Widget _buildFileLink(BuildContext context, String label, String url, String type, String title) {
     return Padding(
       padding: const EdgeInsets.only(right: 12.0),
       child: InkWell(
          onTap: () {
             // Open in Document Viewer for Reading/Downloading
             Navigator.pushNamed(context, '/document-viewer', arguments: {
                'title': title,
                'type': type,
                'url': url,
             });
          },
          child: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
                if (type == 'pdf') 
                  const Icon(Icons.picture_as_pdf, size: 14, color: Colors.black87)
                else
                  const Icon(Icons.description, size: 14, color: Colors.blue),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                     fontSize: 13, 
                     fontWeight: FontWeight.w600, 
                     color: Colors.black87,
                  ),
                ),
             ],
          ),
       ),
     );
  }
}

