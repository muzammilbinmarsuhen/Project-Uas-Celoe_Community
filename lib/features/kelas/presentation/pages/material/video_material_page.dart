import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../data/dummy_course_data.dart';

class VideoMaterialPage extends StatefulWidget {
  const VideoMaterialPage({super.key});

  @override
  State<VideoMaterialPage> createState() => _VideoMaterialPageState();
}

class _VideoMaterialPageState extends State<VideoMaterialPage> {
  late YoutubePlayerController _controller;
  final ScrollController _scrollController = ScrollController();
  
  // Current Video State
  String _currentTitle = 'User Interface Design For Beginner';

  @override
  void initState() {
    super.initState();
    _initController('MQ59TV2D5xU');
  }

  void _initController(String videoId) {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );
  }

  void _changeVideo(String videoId, String title) async {
     // 1. Scroll to top
     if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
     }
     
     // 2. Load Video
     _controller.loadVideoById(videoId: videoId);
     
     // 3. Update Title (AppBar)
     if (mounted) {
        setState(() {
           _currentTitle = title;
        });
     }
  }

  @override
  void dispose() {
    _controller.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Very light grey background
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
           // 1. VIDEO PLAYER (Top)
           Container(
             color: Colors.black,
             child: YoutubePlayer(
               controller: _controller,
               aspectRatio: 16 / 9,
             ),
           ),

           // 2. "Video Lain Nya" Header
           Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                 "Video Lain Nya",
                 style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
           ),

           // 3. Main List (Combined Recommendation + AI for unified look)
           ...DummyCourseData.relatedVideos.asMap().entries.map((entry) {
              return _buildVideoItem(entry.value, entry.key, false);
           }),
           ...DummyCourseData.aiRecommendations.asMap().entries.map((entry) {
              return _buildVideoItem(entry.value, entry.key + DummyCourseData.relatedVideos.length, true);
           }),

           const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildVideoItem(Map<String, String> video, int index, bool isAI) {
     return _AnimatedVideoCard(
        video: video,
        index: index,
        onTap: () => _changeVideo(
           video['id'] ?? '', 
           video['title'] ?? '',
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
