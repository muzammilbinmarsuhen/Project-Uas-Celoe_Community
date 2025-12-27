import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models.dart';
import 'dart:io';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final VoidCallback onBack;
  final VoidCallback onEditAvatar;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.onBack,
    required this.onEditAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, bottom: 80), // Extra bottom padding for floating card
      decoration: const BoxDecoration(
        color: Color(0xFFA82E2E), // Primary Maroon
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          // Nav Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Spacer(),
                IconButton(
                   onPressed: () {}, // Optional settings or extra action
                   icon: const Icon(Icons.settings, color: Colors.white70),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 10),

          // Avatar & Name
          Hero(
            tag: 'profile_avatar',
            child: GestureDetector(
               onTap: onEditAvatar,
               child: Stack(
                 alignment: Alignment.bottomRight,
                 children: [
                    TweenAnimationBuilder<double>(
                      key: ValueKey(user.photoPath ?? user.avatarUrl),
                      tween: Tween(begin: 0.8, end: 1.0),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: _getAvatarImage(),
                        child: _getAvatarImage() == null
                            ? Text(
                                user.username.isNotEmpty ? user.username[0].toUpperCase() : '?',
                                style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFA82E2E),
                                ),
                              )
                            : null,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Color(0xFFA82E2E), size: 20),
                    ),
                 ],
               ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _getFullName(user).toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            user.email,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider? _getAvatarImage() {
    if (user.photoPath != null && user.photoPath!.isNotEmpty) {
      // Handle Web Blob URLs or Network Images
      if (user.photoPath!.startsWith('http') || user.photoPath!.startsWith('blob:')) {
        return NetworkImage(user.photoPath!);
      }
      // Handle Local File System (Mobile/Desktop)
      return FileImage(File(user.photoPath!));
    }
    if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
      return NetworkImage(user.avatarUrl!);
    }
    return null;
  }

  String _getFullName(UserModel user) {
    if (user.firstName != null && user.firstName!.isNotEmpty) {
      if (user.lastName != null && user.lastName!.isNotEmpty) {
         return '${user.firstName} ${user.lastName}';
      }
      return user.firstName!;
    }
    return user.username;
  }
}
