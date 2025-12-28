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
  String _currentDesc = 'Pelajari dasar-dasar desain antarmuka pengguna (UI) mulai dari prinsip layout, warna, hingga tipografi.';
  bool _isLoading = false;

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

  void _changeVideo(String videoId, String title, String desc) async {
     // 1. Scroll to top
     if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
     }

     // 2. Show Loading Skeleton logic (visual only since iframe handles loading internally, but we can fake it for text)
     setState(() => _isLoading = true);
     
     // 3. Load Video
     _controller.loadVideoById(videoId: videoId);
     // Note: If using iframe, loadVideoById might auto-play. 
     
     // 4. Update Text with delay for effect
     await Future.delayed(const Duration(milliseconds: 600));
     if (mounted) {
        setState(() {
           _currentTitle = title;
           _currentDesc = desc;
           _isLoading = false;
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
      backgroundColor: Colors.white, // Clean background
      appBar: AppBar(
        backgroundColor: const Color(0xFFA82E2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Video – User Interface Design For Beginner",
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
           YoutubePlayer(
             controller: _controller,
             aspectRatio: 16 / 9,
           ),

           // 2. VIDEO INFO
           Padding(
             padding: const EdgeInsets.all(20),
             child: _isLoading 
                ? _buildSkeletonDetails() 
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                          _currentTitle,
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                       ),
                       const SizedBox(height: 8),
                       Text(
                          _currentDesc,
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
                       ),
                    ],
                 ),
           ),

           const Divider(thickness: 8, color: Color(0xFFF5F5F5)),

           // 3. "Rekaman Zoom Lainnya"
           _buildSectionHeader("Rekaman Zoom Lainnya"),
           _buildVideoList(DummyCourseData.relatedVideos, isZoom: true),

           const Divider(thickness: 8, color: Color(0xFFF5F5F5)),

           // 4. "Rekomendasi Video (AI)"
           _buildSectionHeader("Rekomendasi Video (AI)"),
           _buildVideoList(DummyCourseData.aiRecommendations, isZoom: false),
           
           const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
     return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Text(
           title,
           style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
     );
  }

  Widget _buildVideoList(List<Map<String, String>> videos, {required bool isZoom}) {
     return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: videos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
           final video = videos[index];
           return _AnimatedVideoCard(
              video: video,
              index: index,
              isZoom: isZoom,
              onTap: () => _changeVideo(
                 video['id'] ?? '', 
                 video['title'] ?? '',
                 isZoom 
                    ? 'Rekaman sesi Zoom untuk topik ${video['title']}. Pelajari materi ini untuk memperdalam pemahaman Anda.'
                    : 'Video rekomendasi AI yang disesuaikan dengan kebutuhan belajar Anda. Topik: ${video['title']}.'
              ),
           );
        },
     );
  }

  Widget _buildSkeletonDetails() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(width: 250, height: 24, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
           const SizedBox(height: 8),
           Container(width: double.infinity, height: 16, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4))),
           const SizedBox(height: 4),
           Container(width: 200, height: 16, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4))),
        ],
     );
  }
}

class _AnimatedVideoCard extends StatefulWidget {
  final Map<String, String> video;
  final int index;
  final bool isZoom;
  final VoidCallback onTap;

  const _AnimatedVideoCard({
     required this.video, 
     required this.index, 
     required this.isZoom,
     required this.onTap
  });

  @override
  State<_AnimatedVideoCard> createState() => _AnimatedVideoCardState();
}

class _AnimatedVideoCardState extends State<_AnimatedVideoCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    
    // Staggered Entrance
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
       if (mounted) _controller.forward();
    });

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
       CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart)
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
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
         child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            onTap: widget.onTap,
            child: AnimatedScale(
               scale: _isPressed ? 0.98 : 1.0,
               duration: const Duration(milliseconds: 100),
               child: Container(
                  decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(12),
                     boxShadow: [
                        BoxShadow(
                           color: Colors.black.withValues(alpha: 0.05),
                           blurRadius: 10,
                           offset: const Offset(0, 4),
                        )
                     ],
                  ),
                  child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        // Thumbnail
                        ClipRRect(
                           borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                           child: Stack(
                              children: [
                                 Image.network(
                                    widget.video['thumb'] ?? '',
                                    width: 120,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_,__,___) => Container(width: 120, height: 90, color: Colors.grey[300]),
                                 ),
                                 Positioned.fill(
                                    child: Center(
                                       child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), shape: BoxShape.circle),
                                          child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                                       ),
                                    ),
                                 ),
                                 Positioned(
                                    bottom: 4, right: 4,
                                    child: Container(
                                       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                       decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(4)),
                                       child: Text(widget.video['duration'] ?? '00:00', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                    ),
                                 )
                              ],
                           ),
                        ),
                        
                        // Content
                        Expanded(
                           child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    if (!widget.isZoom)
                                       Container(
                                          margin: const EdgeInsets.only(bottom: 4),
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                             color: Colors.blue.withValues(alpha: 0.1),
                                             borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                             "AI Recommended",
                                             style: GoogleFonts.poppins(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.w600),
                                          ),
                                       ),
                                    Text(
                                       widget.video['title'] ?? 'No Title',
                                       style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                                       maxLines: 2,
                                       overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                       '${widget.video['author']} • ${widget.video['views']}',
                                       style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                                       maxLines: 1,
                                    ),
                                 ],
                              ),
                           ),
                        )
                     ],
                  ),
               ),
            ),
         ),
      ),
    );
  }
}
