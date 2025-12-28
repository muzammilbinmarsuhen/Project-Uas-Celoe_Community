import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentViewerPage extends StatefulWidget {
  final String title;
  final String type; // 'pdf', 'ppt', 'doc', 'slide'
  final String? url;

  const DocumentViewerPage({
    super.key, 
    required this.title, 
    required this.type,
    this.url
  });

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  Future<void> _downloadFile() async {
    if (widget.url != null) {
      final Uri uri = Uri.parse(widget.url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Could not launch download URL')),
           );
        }
      }
    }
  }

  void _initWebView() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
    
    // NavigationDelegate is often not fully supported on Web
    if (!kIsWeb) {
      controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
             if (mounted) {
               setState(() {
                 _isLoading = true;
                 _hasError = false;
               });
             }
          },
          onPageFinished: (String url) {
             if (mounted) {
               setState(() => _isLoading = false);
             }
          },
          onWebResourceError: (WebResourceError error) {
             if (mounted) {
               setState(() {
                 _isLoading = false;
                 _hasError = true;
               });
             }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
       Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _isLoading = false);
          }
       });
    }
    
    // Logic for Viewer URL
    String finalUrl = widget.url ?? '';
    
    if (['doc', 'docx', 'ppt', 'pptx'].contains(widget.type.toLowerCase())) {
       // Microsoft Office Viewer
       finalUrl = 'https://view.officeapps.live.com/op/view.aspx?src=${widget.url}';
    } else if (widget.type.toLowerCase() == 'pdf') {
       // Google Docs Viewer for PDF to avoid auto-download and enable online reading
       finalUrl = 'https://docs.google.com/viewer?url=${widget.url}&embedded=true';
    } 
    else if (!finalUrl.startsWith('http')) {
       finalUrl = 'https://google.com'; 
    }

    if (finalUrl.isNotEmpty) {
       controller.loadRequest(Uri.parse(finalUrl));
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.poppins(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
            Text(
               widget.type.toUpperCase(),
               style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
           IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black87),
              onPressed: () => _controller.reload(),
              tooltip: "Muat Ulang",
           ),
           IconButton(
              icon: const Icon(Icons.download_for_offline_outlined, color: Colors.black87),
              onPressed: _downloadFile,
              tooltip: "Unduh File",
           ),
        ],
      ),
      body: Stack(
        children: [
           if (!_hasError) WebViewWidget(controller: _controller),
           
           if (_hasError)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      "Gagal memuat dokumen",
                      style: GoogleFonts.poppins(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _controller.reload(),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text("Coba Lagi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA82E2E), // Maroon
                        foregroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

           if (_isLoading && !_hasError)
             const Center(child: CircularProgressIndicator(color: Color(0xFFA82E2E))),
        ],
      ),
    );
  }
}
