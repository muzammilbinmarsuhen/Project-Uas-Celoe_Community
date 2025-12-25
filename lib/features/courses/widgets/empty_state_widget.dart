import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;

  const EmptyStateWidget({
    super.key,
    this.message = 'Tidak Ada Tugas Dan Kuis Hari Ini',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use local asset if available, or a styled icon as fallback if asset is missing in prompt detailed check
            // The prompt asks for "Image.asset". I will use the "uim.jpg" found earlier or a placeholder if I am unsure of the specific illustration name.
            // But since I found 'Learning Management System.png' in step 40, I'll use that or a generic one.
            // Prompt says: "Illustration image (Image.asset)"
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
               child: ClipOval(
                child: Image.asset(
                  'assets/images/Learning Management System.png', // Using available asset
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.folder_open_rounded, size: 80, color: Colors.grey[300]);
                  },
                ),
               ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
