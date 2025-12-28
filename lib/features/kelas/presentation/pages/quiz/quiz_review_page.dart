import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/dummy_course_data.dart';

class QuizReviewPage extends StatelessWidget {
  const QuizReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments with safe casting
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final double score = (args['score'] as num?)?.toDouble() ?? 0.0;
    final int correct = args['correct'] ?? 0;
    final int wrong = args['wrong'] ?? 0;
    final int total = args['total'] ?? 0;
    final Map<int, String> answers = args['answers'] ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xffB74B4B),
        title: Text(
          'Hasil Quiz',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: IconButton(
           icon: const Icon(Icons.close, color: Colors.white),
           onPressed: () => Navigator.pop(context), 
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
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                              _buildResultInfo('Benar', '$correct', Colors.green),
                              _buildResultInfo('Salah', '$wrong', Colors.red),
                              _buildResultInfo('Total', '$total', Colors.black87),
                           ],
                        ),
                        const Divider(height: 30),
                        Text('Nilai Kamu', style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(
                            score.toStringAsFixed(0), 
                            style: GoogleFonts.poppins(
                                fontSize: 48, 
                                fontWeight: FontWeight.bold, 
                                color: score >= 70 ? Colors.green : const Color(0xffB74B4B)
                            )
                        ),
                        Text('/ 100', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                     ],
                  ),
               ),
               const SizedBox(height: 24),
               
               // Question List
               ...DummyCourseData.quizQuestions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final question = entry.value;
                  
                  // Check correctness
                  final selectedId = answers[index];
                  final correctOption = question.options.firstWhere((o) => o.isCorrect, orElse: () => QuizOption(id: '', text: '', isCorrect: false));
                  final isCorrect = selectedId == correctOption.id;
                  final isSkipped = selectedId == null;
                  
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
                                 Text('Soal ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                                 Icon(
                                    isCorrect ? Icons.check_circle : (isSkipped ? Icons.warning : Icons.cancel),
                                    color: isCorrect ? Colors.green : (isSkipped ? Colors.orange : Colors.red),
                                    size: 20
                                 )
                              ],
                           ),
                           const SizedBox(height: 8),
                           Text(
                               question.text,
                               style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
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
                                    const SizedBox(width: 8),
                                    Expanded(
                                       child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              Text(
                                                 isCorrect 
                                                     ? 'Jawaban Benar' 
                                                     : (isSkipped ? 'Tidak Dijawab' : 'Jawaban Salah'),
                                                 style: GoogleFonts.poppins(
                                                     fontSize: 12, 
                                                     color: isCorrect ? Colors.green[800] : Colors.red[800], 
                                                     fontWeight: FontWeight.w500
                                                 ),
                                              ),
                                              if (!isCorrect && !isSkipped) ...[
                                                 const SizedBox(height: 4),
                                                 Text(
                                                    'Jawaban Benar: ${correctOption.id}. ${correctOption.text}',
                                                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.green[800]),
                                                 )
                                              ]
                                          ]
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
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             ElevatedButton(
               onPressed: () {
                  // Retake Quiz -> Reset by replacing route with quiz start
                  Navigator.pushReplacementNamed(context, '/quiz-start');
               },
               style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffB74B4B),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
               ),
               child: Text('Ulangi Quiz', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
             ),
             const SizedBox(height: 12),
             TextButton(
               onPressed: () => Navigator.pop(context), // Back to prev
               child: Text('Kembali ke Materi', style: GoogleFonts.poppins(color: Colors.grey[700])),
             )
           ],
         ),
      ),
    );
  }

  Widget _buildResultInfo(String label, String value, Color valueColor) {
     return Column(
        children: [
           Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
           const SizedBox(height: 4),
           Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: valueColor)),
        ],
     );
  }
}
