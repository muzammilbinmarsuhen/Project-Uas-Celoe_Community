import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';

class HeaderWidget extends StatelessWidget {
  final String username;
  final String? avatarUrl;
  final String? photoPath;
  final VoidCallback? onProfileTap;

  const HeaderWidget({
    super.key,
    required this.username,
    this.avatarUrl,
    this.photoPath,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {


    final String greetingName = username.isEmpty ? 'MAHASISWA' : username.toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFB74A4A), // Lighter Red
            Color(0xFFA82E2E), // Primary Red
            Color(0xFF8F1E1E), // Darker Red
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
             color: Color(0x40A82E2E),
             blurRadius: 15,
             offset: Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Greeting Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hallo,',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  greetingName,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Badge
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    'MAHASISWA',
                    style: GoogleFonts.poppins(
                       color: const Color(0xFFA82E2E), // Red Text
                       fontSize: 10,
                       fontWeight: FontWeight.w800,
                       letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border: Border.all(color: const Color(0xFFA82E2E), width: 1.5),
                    ),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _getAvatarImage(),
                      child: _getAvatarImage() == null
                          ? const Icon(Icons.person, size: 16, color: Colors.grey)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider? _getAvatarImage() {
    if (photoPath != null && photoPath!.isNotEmpty) {
      if (photoPath!.startsWith('http') || photoPath!.startsWith('blob:')) {
        return NetworkImage(photoPath!);
      }
      return FileImage(File(photoPath!));
    }
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    }
    return null;
  }
}
