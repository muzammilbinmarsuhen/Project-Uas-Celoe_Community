import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_review_page.dart';

class QuizQuestionPage extends StatefulWidget {
  const QuizQuestionPage({super.key});

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int _currentQuestionIndex = 0;
  final int _totalQuestions = 10;
  String? _selectedAnswer;

  void _nextQuestion() {
    if (_currentQuestionIndex < _totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null; // Reset selection for mock
      });
    } else {
      // Finish Quiz
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const QuizReviewPage()),
      );
    }
  }

  void _prevQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedAnswer = null; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Kuis - Assessment 2',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.orange, size: 16),
                const SizedBox(width: 8),
                Text(
                  '14:22',
                  style: GoogleFonts.poppins(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Progress Bar
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _totalQuestions,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFA82E2E)),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pertanyaan ${_currentQuestionIndex + 1}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Apa yang dimaksud dengan "Affordance" dalam desain antarmuka pengguna?',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Options
                  _buildOption('A', 'Kemampuan sebuah objek untuk memberi petunjuk cara penggunaannya'),
                  _buildOption('B', 'Konsistensi dalam penggunaan warna pada aplikasi'),
                  _buildOption('C', 'Kecepatan loading sebuah halaman web'),
                  _buildOption('D', 'Struktur navigasi yang bertingkat'),
                  _buildOption('E', 'Semua jawaban salah'),
                ],
              ),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  OutlinedButton(
                    onPressed: _prevQuestion,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text('Sebelumnya', style: GoogleFonts.poppins(color: Colors.black)),
                  )
                else
                  const SizedBox(width: 1), // Spacer
                  
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA82E2E), // Maroon
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    _currentQuestionIndex == _totalQuestions - 1 ? 'Selesai' : 'Selanjutnya',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String label, String text) {
    final isSelected = _selectedAnswer == label;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswer = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA82E2E).withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFA82E2E) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFA82E2E) : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.black87 : Colors.grey[700],
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
