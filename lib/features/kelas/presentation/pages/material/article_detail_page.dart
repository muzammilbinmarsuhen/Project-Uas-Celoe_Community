import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String _title = 'Article Detail';
  String _url = '';

  bool _hasError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
       _title = args['title'] ?? 'Article Detail';
       _url = args['url'] ?? 'https://scholar.google.com';
       _initWebView(_url);
    }
  }

  void _initWebView(String url) {
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
        ),
      );
    } else {
       Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _isLoading = false);
          }
       });
    }

    controller.loadRequest(Uri.parse(url));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: GoogleFonts.poppins(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
            Text(
              _url,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: () => _controller.reload(),
            tooltip: "Muat Ulang",
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87),
            onPressed: () {},
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
                      "Gagal memuat halaman",
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
              const Center(child: CircularProgressIndicator(color: Color(0xFFA82E2E)))
         ],
      ),
    );
  }
}
