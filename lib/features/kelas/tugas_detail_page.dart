import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'upload_tugas_page.dart';

class TugasDetailPage extends StatefulWidget {
  final int assignmentId;
  final String title;
  final String deadline;

  const TugasDetailPage({
    super.key,
    required this.assignmentId,
    required this.title,
    required this.deadline,
  });

  @override
  State<TugasDetailPage> createState() => _TugasDetailPageState();
}

class _TugasDetailPageState extends State<TugasDetailPage> {
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Tugas',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _isSubmitted ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isSubmitted ? Colors.green[100]! : Colors.orange[100]!,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status Pengumpulan',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _isSubmitted ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _isSubmitted ? 'Selesai' : 'Belum Dikumpulkan',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                     children: [
                        Icon(Icons.access_time_rounded, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.deadline,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                        ),
                     ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Title & Instruction
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Instruksi Pengerjaan',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buatlah analisis antarmuka pengguna pada aplikasi mobile game dengan ketentuan sebagai berikut:\n\n1. Minimal 3 halaman analisis\n2. Format PDF\n3. Sertakan screenshot aplikasi\n4. Jelaskan prinsip desain yang digunakan\n\nKumpulkan sebelum deadline berakhir.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            
            // Upload Button logic
            if (!_isSubmitted)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UploadTugasPage()),
                    );
                    
                    if (result == true) {
                      setState(() {
                         _isSubmitted = true;
                      });
                    }
                  },
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: Text(
                    'Tambahkan Tugas',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA82E2E), // Maroon
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              )
            else 
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.file_present, color: Colors.red),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'My_Assignment_Solution.pdf',
                        style: GoogleFonts.poppins(
                           fontSize: 14,
                           fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
