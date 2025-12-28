import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/dummy_pengumuman.dart';

class PengumumanPage extends StatelessWidget {
  const PengumumanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = DummyPengumuman.list;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias, // Required for ripple to respect border radius
            child: InkWell(
              onTap: () {
                 Navigator.pushNamed(
                   context, 
                   '/announcement-detail',
                   arguments: {
                     'title': item.title,
                     'date': item.date,
                     'description': item.content,
                     'image': 'https://images.unsplash.com/photo-1557804506-669a67965ba0?auto=format&fit=crop&w=800&q=80',
                   }
                 );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                           decoration: BoxDecoration(
                             color: AppTheme.primaryMaroon.withValues(alpha: 0.1),
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: Text(
                             item.category,
                             style: GoogleFonts.poppins(
                               fontSize: 10,
                               fontWeight: FontWeight.bold,
                               color: AppTheme.primaryMaroon,
                             ),
                           ),
                         ),
                         Text(
                           item.date,
                           style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                         ),
                       ],
                     ),
                     const SizedBox(height: 8),
                     Text(
                       item.title,
                       style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 4),
                     Text(
                       item.content,
                       style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                     ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
