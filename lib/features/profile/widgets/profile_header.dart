import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final ImageProvider? imageProvider;
  final VoidCallback? onEditAvatar;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.avatarUrl,
    this.imageProvider,
    this.onEditAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 32,
        left: 16,
        right: 16,
      ),
      color: const Color(0xFFA82E2E), // Primary Red
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Spacer(), // Balance the arrow
              const SizedBox(width: 48), // Approximate width of back arrow for centering if needed
            ],
          ),
          const SizedBox(height: 16),
          // Avatar
          GestureDetector(
            onTap: onEditAvatar,
            child: Hero(
              tag: 'profile-avatar',
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: imageProvider ?? (avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null),
                      child: (imageProvider == null && avatarUrl.isEmpty)
                          ? const Icon(Icons.person, size: 50, color: Colors.grey)
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: const Icon(Icons.camera_alt, color: Color(0xFFA82E2E), size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            name.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
