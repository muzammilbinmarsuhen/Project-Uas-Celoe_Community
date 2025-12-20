import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../core/models.dart';

class MaterialScreen extends StatefulWidget {
  final Module module;

  const MaterialScreen({super.key, required this.module});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  VideoPlayerController? _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.module.type == 'video') {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.module.contentUrl))
        ..initialize().then((_) {
          setState(() {
            _isVideoInitialized = true;
          });
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module.title),
        backgroundColor: const Color(0xFFB22222),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.module.type == 'video' && _isVideoInitialized)
                AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              if (widget.module.type == 'video')
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller!.value.isPlaying
                          ? _controller!.pause()
                          : _controller!.play();
                    });
                  },
                  child: Text(
                    _controller!.value.isPlaying ? 'Pause' : 'Play',
                  ),
                ),
              if (widget.module.type == 'text')
                Text(
                  widget.module.contentUrl, // Assuming contentUrl is the text content
                  style: const TextStyle(fontSize: 16),
                ),
              // For PDF, would need additional implementation
            ],
          ),
        ),
      ),
    );
  }
}