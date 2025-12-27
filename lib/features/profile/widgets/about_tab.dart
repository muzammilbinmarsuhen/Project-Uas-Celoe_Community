import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models.dart';
import '../profile_controller.dart';

class AboutTab extends ConsumerWidget {
  final UserModel user;

  const AboutTab({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildInfoItem(Icons.person, 'Tentang Saya', user.description ?? '-'),
        _buildInfoItem(Icons.school, 'Fakultas', user.faculty ?? '-'),
        _buildInfoItem(Icons.menu_book, 'Program Studi', user.studyProgram ?? '-'),
        _buildInfoItem(Icons.email, 'Email', user.email),
        _buildInfoItem(Icons.public, 'Negara', user.country ?? '-'),
        const Divider(height: 30),
        _buildInfoItem(Icons.login, 'Login Pertama', _formatDate(user.firstAccess)),
        _buildInfoItem(Icons.access_time_filled, 'Terakhir Login', _formatDate(user.lastAccess)),
        const SizedBox(height: 20),
        _buildLogoutButton(context, ref),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row( // ... same content ...
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                 color: const Color(0xFFA82E2E).withValues(alpha: 0.1),
                 borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFFA82E2E), size: 22),
           ),
           const SizedBox(width: 16),
           Expanded(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(
                       label,
                       style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                       value,
                       style: GoogleFonts.poppins(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                 ],
              ),
           ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
     return Align(
       alignment: Alignment.centerRight,
       child: SizedBox(
         width: 140, // Fixed width for a compact button
         child: OutlinedButton.icon(
           onPressed: () {
              ref.read(profileControllerProvider.notifier).logout(context);
           },
           style: OutlinedButton.styleFrom(
             foregroundColor: Colors.red,
             side: const BorderSide(color: Colors.red, width: 1.5),
             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
           ),
           icon: const Icon(Icons.logout, size: 20),
           label: Text('Keluar', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
         ),
       ),
     );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}';
  }
}
