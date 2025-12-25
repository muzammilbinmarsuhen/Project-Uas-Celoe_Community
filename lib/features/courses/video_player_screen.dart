import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoMateriPage extends StatelessWidget {
  const VideoMateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Video Materi',
          style: GoogleFonts.poppins(
             color: Colors.black,
             fontWeight: FontWeight.w600,
             fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mock Video Player
          Container(
            width: double.infinity,
            height: 220,
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                 const Icon(Icons.play_circle_filled, size: 60, color: Colors.white),
                 Positioned(
                   bottom: 10,
                   left: 10,
                   child: Text(
                     '00:00 / 12:30',
                     style: GoogleFonts.poppins(
                       color: Colors.white,
                       fontSize: 12,
                     ),
                   ),
                 ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Pengantar User Interface Design',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Video ini menjelaskan filosofi dasar dalam mendesain antarmuka yang baik dan mudah digunakan.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Video Lainnya',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildRelatedVideoItem('Prinsip Gestalt', '10:15'),
                _buildRelatedVideoItem('Color Theory', '08:45'),
                _buildRelatedVideoItem('Typography in UI', '15:20'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedVideoItem(String title, String duration) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.play_arrow, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Durasi: $duration',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
