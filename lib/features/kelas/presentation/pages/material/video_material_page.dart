import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../data/dummy_course_data.dart';

class VideoMaterialPage extends StatefulWidget {
  const VideoMaterialPage({super.key});

  @override
  State<VideoMaterialPage> createState() => _VideoMaterialPageState();
}

class _VideoMaterialPageState extends State<VideoMaterialPage> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'MQ59TV2D5xU', // UI Design Tutorial
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      // Logic for non-fullscreen updates if needed
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behavior.
        // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFFA82E2E),
        progressColors: const ProgressBarColors(
           playedColor: Color(0xFFA82E2E),
           handleColor: Colors.white,
        ),
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
         return Scaffold(
            backgroundColor: const Color(0xFFF9FAFB),
            appBar: AppBar(
               backgroundColor: const Color(0xFFA82E2E),
               leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
               ),
               title: Text(
                  'Video Materi',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
               ),
               elevation: 0,
            ),
            body: Column(
               children: [
                  player,
                  Expanded(
                     child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                           Text(
                              'Rekaman Zoom Meeting - Pertemuan 1',
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                           ),
                           const SizedBox(height: 8),
                           Text(
                              'Pembahasan mendalam mengenai teori dasar UI Design dan implementasi studi kasus sederhana menggunakan Figma.',
                              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                           ),
                           const SizedBox(height: 24),
                           Text('Video Lainnya', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                           const SizedBox(height: 12),
                           
                           // Related Videos
                           ...DummyCourseData.relatedVideos.map((video) {
                              return InkWell(
                                 onTap: () {
                                    // In a real app, this would load a new video ID
                                    ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(content: Text('Memutar: ${video['title']}'))
                                    );
                                 },
                                 child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                       children: [
                                          Container(
                                             width: 120, height: 80,
                                             decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(12),
                                                image: const DecorationImage(
                                                   image: NetworkImage('https://img.youtube.com/vi/MQ59TV2D5xU/0.jpg'), // Mock thumbnail
                                                   fit: BoxFit.cover,
                                                   opacity: 0.7
                                                )
                                             ),
                                             child: const Center(child: Icon(Icons.play_circle_outline, color: Colors.white, size: 30)),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                             child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                   Text(
                                                      video['title']!, 
                                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                                   ),
                                                   const SizedBox(height: 4),
                                                   Text(
                                                      'Durasi: ${video['duration']}',
                                                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                                                   ),
                                                ],
                                             ),
                                          )
                                       ],
                                    ),
                                 ),
                              );
                           }),
                        ],
                     ),
                  )
               ],
            ),
         );
      },
    );
  }
}
