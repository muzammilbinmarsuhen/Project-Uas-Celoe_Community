import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/dummy_course_data.dart';
import '../../../../routes/app_routes.dart';

class MaterialTab extends StatelessWidget {
  const MaterialTab({super.key});

  @override
  Widget build(BuildContext context) {
    final materials = DummyCourseData.materials;

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        return _buildMaterialCard(context, materials[index], index);
      },
    );
  }

  Widget _buildMaterialCard(BuildContext context, MaterialItem item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.materialDetail, arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Section with image placeholder if needed, 
            // but prompt says "Gambar disesuaikan dengan nama materi" (Illustration)
            // We'll put an illustration on the left or top. Let's do a Row layout.
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Illustration Placeholder
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image, color: Colors.blue, size: 30),
                  ),
                  const SizedBox(width: 16),
                  
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.meetingTitle,
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status Icon
                  Icon(
                    item.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                    color: item.isCompleted ? Colors.green : Colors.grey[300],
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
