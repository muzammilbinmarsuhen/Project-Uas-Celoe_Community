import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/dummy_course_data.dart';

class QuizReviewPage extends StatelessWidget {
  const QuizReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xffB74B4B),
        title: Text(
          'Review Jawaban',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: IconButton(
           icon: const Icon(Icons.close, color: Colors.white),
           onPressed: () => Navigator.pop(context), // Typically would go back to overview or class
        ),
      ),
      body: SingleChildScrollView(
         padding: const EdgeInsets.all(20),
         child: Column(
            children: [
               // Result Card
               Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(16),
                     boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
                     ]
                  ),
                  child: Column(
                     children: [
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              _buildResultInfo('Mulai', '08:00'),
                              _buildResultInfo('Selesai', '08:14'),
                              _buildResultInfo('Durasi', '14m 12s'),
                           ],
                        ),
                        const Divider(height: 30),
                        Text('Nilai Kamu', style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('85.00', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xffB74B4B))),
                        Text('/ 100', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                     ],
                  ),
               ),
               const SizedBox(height: 24),
               
               // Question List
               ...DummyCourseData.quizQuestions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final question = entry.value;
                  // Mock answers: odd correct, even incorrect
                  final isCorrect = index % 2 == 0; 
                  
                  return Container(
                     margin: const EdgeInsets.only(bottom: 16),
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!)
                     ),
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text('Soal ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13, color: const Color(0xffB74B4B))),
                                 TextButton(
                                    onPressed: () {
                                       // In backend app this would go to Question Page in ReadOnly mode.
                                       // Here just show a snackbar
                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lihat detail soal ${index + 1}')));
                                    },
                                    child: Text('Lihat Soal', style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue)),
                                 )
                              ],
                           ),
                           const SizedBox(height: 8),
                           Text(
                              question.text,
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                           ),
                           const SizedBox(height: 12),
                           Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                 color: isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                                 borderRadius: BorderRadius.circular(8)
                              ),
                              child: Row(
                                 children: [
                                    Icon(
                                       isCorrect ? Icons.check_circle : Icons.cancel,
                                       color: isCorrect ? Colors.green : Colors.red,
                                       size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                       child: Text(
                                          'Jawaban tersimpan',
                                          style: GoogleFonts.poppins(fontSize: 12, color: isCorrect ? Colors.green[800] : Colors.red[800], fontWeight: FontWeight.w500),
                                       ),
                                    )
                                 ],
                              ),
                           )
                        ],
                     ),
                  );
               })
            ],
         ),
      ),
      bottomNavigationBar: Container(
         padding: const EdgeInsets.all(20),
         decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
               BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -4))
            ] 
         ),
         child: ElevatedButton(
            onPressed: () {
               // Success Animation Logic
               showDialog(context: context, builder: (ctx) => AlertDialog(
                  content: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                        const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
                        const SizedBox(height: 16),
                        Text('Sukses!', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('Jawaban berhasil dikirim.', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
                     ],
                  ),
                  actions: [
                     TextButton(child: const Text('OK'), onPressed: () {
                        Navigator.pop(ctx); // Close dialog
                        Navigator.pop(context); // Close review page -> Back to Overview
                     })
                  ],
               ));
            },
            style: ElevatedButton.styleFrom(
               backgroundColor: Colors.green,
               minimumSize: const Size(double.infinity, 50),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
            ),
            child: Text('Kirim Jawaban', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
         ),
      ),
    );
  }

  Widget _buildResultInfo(String label, String value) {
     return Column(
        children: [
           Text(label, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
           const SizedBox(height: 4),
           Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
     );
  }
}
