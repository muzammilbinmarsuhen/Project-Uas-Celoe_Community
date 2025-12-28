import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentViewerPage extends StatefulWidget {
  final String title;
  final String type; // 'pdf', 'ppt', 'doc', 'slide'

  const DocumentViewerPage({
    super.key, 
    required this.title, 
    required this.type
  });

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading a document
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA82E2E), // Maroon
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
        actions: [
           IconButton(
              icon: const Icon(Icons.download, color: Colors.white),
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Mengunduh ${widget.title}...'))
                 );
              },
           ),
        ],
      ),
      body: _isLoading 
         ? const Center(child: CircularProgressIndicator(color: Color(0xFFA82E2E)))
         : _buildDocumentContent(widget.type),
    );
  }

  Widget _buildDocumentContent(String type) {
     switch (type.toLowerCase()) {
       case 'pdf':
          return _buildMockPDFViewer();
       case 'ppt':
          return _buildMockPPTViewer();
       case 'doc':
          return _buildMockWordViewer();
       default:
          return const Center(child: Text("Format tidak didukung"));
     }
  }

  Widget _buildMockPDFViewer() {
     return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
           children: List.generate(5, (index) => 
              Container(
                 height: 500,
                 margin: const EdgeInsets.only(bottom: 16),
                 width: double.infinity,
                 decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 5)],
                 ),
                 child: Stack(
                   children: [
                      Center(
                         child: Opacity(
                            opacity: 0.05,
                            child: Icon(Icons.picture_as_pdf, size: 200, color: Colors.red),
                         ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              Text("Halaman ${index + 1}", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 16),
                              Container(height: 16, width: 200, color: Colors.grey[200]),
                              const SizedBox(height: 8),
                              Container(height: 16, width: double.infinity, color: Colors.grey[200]),
                              const SizedBox(height: 8),
                              Container(height: 16, width: double.infinity, color: Colors.grey[200]),
                              const SizedBox(height: 8),
                              Container(height: 16, width: 250, color: Colors.grey[200]),
                              const SizedBox(height: 32),
                              // Mock Image
                              Expanded(
                                 child: Container(
                                    width: double.infinity,
                                    color: Colors.grey[100],
                                    child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                                 ) 
                              )
                           ],
                        ),
                      )
                   ],
                 ),
              )
           ),
        ),
     );
  }

  Widget _buildMockPPTViewer() {
    // Horizontal Scroll for Slides
    return PageView.builder(
       itemCount: 8,
       itemBuilder: (context, index) {
          return Container(
             margin: const EdgeInsets.all(16),
             decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
             ),
             child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("Slide ${index + 1}", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
                   const SizedBox(height: 20),
                   Container(
                      height: 200, width: 300,
                      decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(8)),
                      child: const Center(child: Icon(Icons.bar_chart, size: 80, color: Colors.orange)),
                   ),
                   const SizedBox(height: 20),
                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                         textAlign: TextAlign.center,
                         style: GoogleFonts.poppins(color: Colors.grey[600]),
                      ),
                   )
                ],
             ),
          );
       },
    );
  }

  Widget _buildMockWordViewer() {
    return Container(
       margin: const EdgeInsets.all(16),
       padding: const EdgeInsets.all(24),
       width: double.infinity,
       decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 5)],
       ),
       child: SingleChildScrollView(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Text(widget.title, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                ...List.generate(6, (index) => Padding(
                   padding: const EdgeInsets.only(bottom: 16),
                   child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                      style: GoogleFonts.poppins(fontSize: 14, height: 1.6, color: Colors.black87),
                      textAlign: TextAlign.justify,
                   ),
                )),
             ],
          ),
       ),
    );
  }
}
