import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';


class PengaduanPage extends StatelessWidget {
  const PengaduanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan Pengaduan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Icon(Icons.support_agent, size: 80, color: AppTheme.primaryMaroon),
             const SizedBox(height: 16),
             Text(
               'Fitur Pengaduan Segera Hadir',
               style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 8),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 32),
               child: Text(
                 'Kami sedang menyiapkan formulir layanan pengaduan terbaik untuk anda.',
                 textAlign: TextAlign.center,
                 style: GoogleFonts.poppins(color: Colors.grey),
               ),
             ),
             const SizedBox(height: 24),
             ElevatedButton(
                onPressed: () {},
                child: const Text('Buat Pengaduan (Demo)'),
             ),
          ],
        ),
      ),
    );
  }
}
