import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengumumanDetailPage extends StatelessWidget {
  final int index;

  const PengumumanDetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // Determine content based on index or static example
    final title = 'Maintenance Pra UAS Semester Genap 2020/2021';
    final date = '10 Jan 2024 - 08:30';
    final author = 'Admin CeLOE';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detail Pengumuman',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Illustration
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Learning Management System.png'), // Using existing asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Meta Info
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB22222).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    author,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFB22222),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Title
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            
            // Content
            Text(
              'Yth. Mahasiswa dan Dosen,\n\nKami informasikan bahwa sistem Learning Management System (LMS) akan mengalami maintenance terjadwal dalam rangka persiapan Ujian Akhir Semester (UAS).',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Detail Maintenance:\n• Tanggal: 12 Januari 2024\n• Waktu: 22.00 - 02.00 WIB\n• Dampak: Sistem tidak dapat diakses selama periode tersebut.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Mohon bagi mahasiswa untuk mengunduh materi yang diperlukan sebelum waktu maintenance dimulai. Pengumpulan tugas yang memiliki deadline pada jam tersebut akan diperpanjang otomatis selama 12 jam.\n\nTerima kasih atas perhatian dan kerjasamanya.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
             Divider(color: Colors.grey[200]),
             const SizedBox(height: 16),
             Text(
                'Hormat Kami,\nTim IT Akademik',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
             ),


          ],
        ),
      ),
    );
  }
}
