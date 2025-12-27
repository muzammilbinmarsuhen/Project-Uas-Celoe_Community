import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementCardWidget extends StatelessWidget {
  final VoidCallback onTap;
  
  const AnnouncementCardWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
             BoxShadow(
               color: Colors.black.withValues(alpha: 0.05), 
               blurRadius: 15, 
               offset: const Offset(0, 4)
             ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Hero(
              tag: 'announce_img',
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Learning Management System.png'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'PENGUMUMAN',
                      style: GoogleFonts.poppins(
                         fontSize: 10,
                         fontWeight: FontWeight.bold,
                         color: Colors.blue[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Maintenance Pra UAS Semester Genap',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                       Text(
                        '10 Jan 2024',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.person_outline_rounded, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                       Text(
                        'Admin CeLOE',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            
            // Arrow
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                 color: Colors.grey[50],
                 borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
