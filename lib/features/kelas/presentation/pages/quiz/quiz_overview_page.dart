import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizOverviewPage extends StatelessWidget {
  const QuizOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xffB74B4B), // Primary Red
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Quiz Review 1',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Slide-in Animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                     'Deskripsi Kuis',
                     style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                   ),
                   const SizedBox(height: 8),
                   Text(
                     'Kuis ini bertujuan untuk menguji pemahaman Anda mengenai prinsip-prinsip dasar User Interface Design yang telah dibahas pada pertemuan pertama.',
                     style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], height: 1.5),
                   ),
                   const SizedBox(height: 20),
                   
                   // Info Card
                   Container(
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                       color: Colors.grey[100],
                       borderRadius: BorderRadius.circular(12),
                       border: Border.all(color: Colors.grey[300]!),
                     ),
                     child: Column(
                       children: [
                         _buildInfoRow('Dibuka', 'Senin, 28 Des 2025, 08:00'),
                         const Divider(height: 24),
                         _buildInfoRow('Ditutup', 'Rabu, 30 Des 2025, 23:59'),
                         const Divider(height: 24),
                         _buildInfoRow('Batasan Waktu', '15 Menit'),
                         const Divider(height: 24),
                         _buildInfoRow('Metode Penilaian', 'Nilai Tertinggi'),
                       ],
                     ),
                   ),
                   const SizedBox(height: 24),

                   Text(
                     'Percobaan Yang Sudah Dilakukan',
                     style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                   ),
                   const SizedBox(height: 12),

                   // Table
                   Container(
                      decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),
                         boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
                         ]
                      ),
                      child: Table(
                         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                         columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                         },
                         children: [
                            TableRow(
                               decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12))
                               ),
                               children: [
                                  Padding(padding: const EdgeInsets.all(12), child: Text('Status', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12))),
                                  Padding(padding: const EdgeInsets.all(12), child: Text('Nilai / 100', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12))),
                                  Padding(padding: const EdgeInsets.all(12), child: Text('Review', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12))),
                               ]
                            ),
                            TableRow(
                               children: [
                                  Padding(padding: const EdgeInsets.all(12), child: Text('Selesai\nDikirim: 28 Des, 09:30', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]))),
                                  Center(child: Text('85.00', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13))),
                                  Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: TextButton(
                                        onPressed: () {
                                           Navigator.pushNamed(context, '/quiz-review');
                                        }, 
                                        child: Text('Lihat', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xffB74B4B)))
                                     ),
                                  )
                               ]
                            )
                         ],
                      ),
                   ),
                   const SizedBox(height: 20),
                   
                   Center(child: Text('Nilai Akhir Anda: 85.00', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold))),
                   const SizedBox(height: 24),

                   // Buttons
                   ElevatedButton(
                      style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xffB74B4B),
                         minimumSize: const Size(double.infinity, 50),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         elevation: 2,
                      ),
                      onPressed: () {
                         Navigator.pushNamed(context, '/quiz-start');
                      }, 
                      child: Text('Ambil Kuis Lagi', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                   ),
                   const SizedBox(height: 12),
                   OutlinedButton(
                      style: OutlinedButton.styleFrom(
                         side: const BorderSide(color: Color(0xffB74B4B)),
                         minimumSize: const Size(double.infinity, 50),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context), 
                      child: Text('Kembali Ke Kelas', style: GoogleFonts.poppins(color: const Color(0xffB74B4B), fontWeight: FontWeight.bold)),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(label, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600])),
           Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
     );
  }
}
