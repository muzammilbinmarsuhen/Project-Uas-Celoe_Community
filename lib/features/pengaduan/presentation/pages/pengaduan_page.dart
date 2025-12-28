import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';


class PengaduanPage extends StatelessWidget {
  const PengaduanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'icon': Icons.school, 'title': 'Layanan Akademik', 'desc': 'Jadwal, KRS, Nilai'},
      {'icon': Icons.monetization_on, 'title': 'Layanan Keuangan', 'desc': 'Pembayaran, Beasiswa'},
      {'icon': Icons.wifi, 'title': 'Fasilitas & IT', 'desc': 'AC, WiFi, Proyektor'},
      {'icon': Icons.book, 'title': 'Perpustakaan', 'desc': 'Buku, E-Journal'},
      {'icon': Icons.campaign, 'title': 'Kemahasiswaan', 'desc': 'Organisasi, Lomba'},
      {'icon': Icons.security, 'title': 'Keamanan & Kebersihan', 'desc': 'Parkir, Toilet'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan Pengaduan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final item = services[index];
          return Card(
             margin: const EdgeInsets.only(bottom: 16),
             elevation: 2,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
             child: ListTile(
               leading: Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   color: AppTheme.primaryMaroon.withValues(alpha: 0.1),
                   shape: BoxShape.circle,
                 ),
                 child: Icon(item['icon'] as IconData, color: AppTheme.primaryMaroon),
               ),
               title: Text(item['title'] as String, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
               subtitle: Text(item['desc'] as String, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
               trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
               onTap: () {
                 Navigator.pushNamed(context, '/pengaduan-form', arguments: item['title']);
               },
             ),
          );
        },
      ),
    );
  }
}
