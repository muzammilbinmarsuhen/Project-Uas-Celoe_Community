import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:video_player/video_player.dart';
import '../../../data/dummy_course_data.dart';

class VideoMaterialPage extends StatefulWidget {
  const VideoMaterialPage({super.key});

  @override
  State<VideoMaterialPage> createState() => _VideoMaterialPageState();
}

class _VideoMaterialPageState extends State<VideoMaterialPage> {
  // YouTube Controller
  late YoutubePlayerController _ytController;
  
  // Generic Video Controller
  VideoPlayerController? _videoController;

  final ScrollController _scrollController = ScrollController();
  
  // Current Video State
  String _currentTitle = 'User Interface Design For Beginner';
  bool _isYoutube = true;

  @override
  void didChangeDependencies() {
     super.didChangeDependencies();
     // Extract args if passed
     final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
     if (args != null) {
        _currentTitle = args['title'] ?? _currentTitle;
        if (args['isYoutube'] == false) {
           _initGenericVideo(args['url']);
        } else {
           _initYoutube(args['id'] ?? 'MQ59TV2D5xU');
        }
     } else {
        _initYoutube('MQ59TV2D5xU');
     }
  }

  void _initYoutube(String videoId) {
    _isYoutube = true;
    _disposeGeneric();
    
    _ytController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );
    setState(() {});
  }

  void _initGenericVideo(String url) {
     _isYoutube = false;
     // If we had a YT controller, we don't necessarily need to dispose it if we want to cache, 
     // but for simplicity let's rely on re-creation or just pause it. 
     // Actually the library recommends closing.
     try { _ytController.close(); } catch (_) {}

     _videoController = VideoPlayerController.networkUrl(Uri.parse(url))
       ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
       });
  }

  void _disposeGeneric() {
     _videoController?.dispose();
     _videoController = null;
  }

  void _changeVideo(String idOrUrl, String title, bool isYoutube) async {
     // 1. Scroll to top
     if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
     }
     
     // 2. Load Video
     if (isYoutube) {
        if (!_isYoutube) {
           _initYoutube(idOrUrl);
        } else {
           _ytController.loadVideoById(videoId: idOrUrl);
        }
     } else {
        _initGenericVideo(idOrUrl);
     }
     
     // 3. Update Title (AppBar)
     if (mounted) {
        setState(() {
           _currentTitle = title;
           _isYoutube = isYoutube;
        });
     }
  }

  @override
  void dispose() {
    try { _ytController.close(); } catch (_) {}
    _videoController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA82E2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Video – $_currentTitle",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
      ),
      body: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        children: [
           // 1. VIDEO PLAYER AREA
           Container(
             color: Colors.black,
             height: 250, // Fixed height for consistency
             width: double.infinity,
             child: Center(
                child: _isYoutube 
                  ? YoutubePlayer(controller: _ytController, aspectRatio: 16 / 9)
                  : (_videoController != null && _videoController!.value.isInitialized)
                      ? AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                               VideoPlayer(_videoController!),
                               VideoProgressIndicator(_videoController!, allowScrubbing: true, colors: const VideoProgressColors(playedColor: Colors.red)),
                               // Simple Play/Pause Overlay
                               GestureDetector(
                                  onTap: () {
                                     setState(() {
                                        _videoController!.value.isPlaying ? _videoController!.pause() : _videoController!.play();
                                     });
                                  },
                                  child: Center(
                                     child: Icon(
                                        _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                        color: Colors.white.withValues(alpha: 0.5),
                                        size: 50
                                     )
                                  ),
                               )
                            ],
                          ),
                        )
                      : const CircularProgressIndicator(color: Colors.white),
             ),
           ),

           // 2. HEADER
           Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                 "Materi Video Lainnya",
                 style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
           ),

           // 3. LIST
           ...DummyCourseData.relatedVideos.asMap().entries.map((entry) {
              return _buildVideoItem(entry.value, entry.key);
           }),
           const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildVideoItem(Map<String, String> video, int index) {
     return _AnimatedVideoCard(
        video: video,
        index: index,
        onTap: () => _changeVideo(
           video['id'] ?? '', 
           video['title'] ?? '',
           true // Assuming related videos in dummy data are YT for now, or check URL structure
        ),
     );
  }
}

class _AnimatedVideoCard extends StatefulWidget {
  final Map<String, String> video;
  final int index;
  final VoidCallback onTap;

  const _AnimatedVideoCard({
     required this.video, 
     required this.index, 
     required this.onTap
  });

  @override
  State<_AnimatedVideoCard> createState() => _AnimatedVideoCardState();
}

class _AnimatedVideoCardState extends State<_AnimatedVideoCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    
    // Staggered Entrance
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
       if (mounted) _controller.forward();
    });

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
       CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
           margin: const EdgeInsets.only(bottom: 16),
           color: Colors.white, // White background for the card area
           child: Material(
             color: Colors.transparent,
             child: InkWell(
               onTap: widget.onTap,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     // Thumbnail (Left)
                     ClipRRect(
                       borderRadius: BorderRadius.circular(4), // Slightly rounded corners, mostly sharp
                       child: Stack(
                         children: [
                           Image.network(
                             widget.video['thumb'] ?? '',
                             width: 140, // Wide thumbnail
                             height: 80,
                             fit: BoxFit.cover,
                             errorBuilder: (_,__,___) => Container(width: 140, height: 80, color: Colors.grey),
                           ),
                           // Tiny play icon overlay? Or just duration. Image shows just Youtube logo in corner?
                           // Let's add a small play graphic on the thumbnail center to indicate clickable
                           Positioned.fill(
                             child: Center(
                               child: Container(
                                 padding: const EdgeInsets.all(4),
                                 decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.8), shape: BoxShape.circle),
                                 child: const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                               ),
                             ),
                           )
                         ],
                       ),
                     ),
                     
                     const SizedBox(width: 16),
                     
                     // Text (Right)
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center, // Center vertically relative to thumbnail height?
                         children: [
                           const SizedBox(height: 4), // Slight top padding
                           Text(
                             widget.video['title'] ?? 'Judul Video',
                             style: GoogleFonts.poppins(
                               fontWeight: FontWeight.w600, 
                               fontSize: 14, 
                               color: Colors.black87
                             ),
                             maxLines: 3,
                             overflow: TextOverflow.ellipsis,
                           ),
                           const SizedBox(height: 8),
                           Row(
                             children: [
                               // Maybe Telkom logo or author name?
                               Text(
                                  widget.video['author'] ?? 'Author',
                                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                               ),
                             ],
                           )
                         ],
                       ),
                     )
                   ],
                 ),
               ),
             ),
           ),
        ),
      ),
    );
  }
}
