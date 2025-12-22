import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilHeaderWidget extends StatelessWidget {
  final String name;
  final String avatarUrl;

  final VoidCallback? onEditAvatar;

  const ProfilHeaderWidget({
    super.key,
    required this.name,
    required this.avatarUrl,
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
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
               onTap: () => Navigator.pop(context),
               child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          // Avatar
          GestureDetector(
            onTap: onEditAvatar,
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
                    // Display image if url is valid, else icon
                    backgroundImage: avatarUrl.isNotEmpty && avatarUrl.startsWith('http') 
                        ? NetworkImage(avatarUrl) 
                        : null,
                    child: (avatarUrl.isEmpty || !avatarUrl.startsWith('http')) 
                        ? const Icon(Icons.person, size: 50, color: Colors.grey) 
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.2),
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
