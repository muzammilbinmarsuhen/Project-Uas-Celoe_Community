import 'package:flutter/material.dart';
import 'antigravity_bottom_v_bar.dart';

class AntiGravityPreview extends StatefulWidget {
  const AntiGravityPreview({super.key});

  @override
  State<AntiGravityPreview> createState() => _AntiGravityPreviewState();
}

class _AntiGravityPreviewState extends State<AntiGravityPreview> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with some color/image to show glassmorphism
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Icon(Icons.auto_awesome_rounded, size: 80, color: Color(0xFFA82E2E)),
                   const SizedBox(height: 20),
                   Text(
                     "AntiGravity UI Preview",
                     style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.bold,
                       color: Colors.grey[800],
                     ),
                   ),
                   const SizedBox(height: 10),
                   Text(
                     "Selected: Section ${_currentIndex + 1}",
                     style: TextStyle(color: Colors.grey[600]),
                   ),
                ],
              ),
            ),
          ),
          
          // The Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AntiGravityBottomNavBar(
              currentIndex: _currentIndex,
              icons: const [
                Icons.home_rounded,
                Icons.school_rounded,
                Icons.chat_bubble_rounded,
                Icons.person_rounded,
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
