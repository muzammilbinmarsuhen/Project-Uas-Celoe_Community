import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../../core/services/api_service.dart';
import 'quiz_review_page.dart';

class QuizQuestionPage extends StatefulWidget {
  final int quizId;
  final String title;

  const QuizQuestionPage({super.key, required this.quizId, required this.title});

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int _currentQuestionIndex = 0;
  List<dynamic> _questions = [];
  final Map<int, int> _selectedAnswers = {}; // questionId -> optionId
  bool _isLoading = true;
  Timer? _timer;
  int _remainingSeconds = 900; // 15 minutes default

  @override
  void initState() {
    super.initState();
    _initQuiz();
  }

  Future<void> _initQuiz() async {
    final api = Provider.of<ApiService>(context, listen: false);
    
    // 1. Start Quiz (creates attempt)
    await api.startQuiz(widget.quizId);

    // 2. Get Questions
    final questions = await api.getQuizQuestions(widget.quizId);
    
    // Mock if empty for demo
    if (questions.isEmpty) {
      _questions = _getMockQuestions();
    } else {
      _questions = questions;
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
        _startTimer();
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _submitQuiz();
      }
    });
  }

  String _formatTime(int seconds) {
    final int min = seconds ~/ 60;
    final int sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _submitQuiz();
    }
  }

  void _prevQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  Future<void> _submitQuiz() async {
    _timer?.cancel();
    // Show loading?
    
    final api = Provider.of<ApiService>(context, listen: false);
    // Logic to send answers could be added here if backend supports it
    await api.submitQuiz(widget.quizId); // Currently mocked logic

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const QuizReviewPage()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Color(0xFFA82E2E))),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final options = question['options'] as List; // Expecting List of Maps or Strings

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
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
                  _formatTime(_remainingSeconds),
                  style: GoogleFonts.poppins(color: Colors.orange[800], fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
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
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    question['question_text'] ?? question['question'] ?? 'Pertanyaan...',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87, height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  
                  ...options.map((option) {
                    // Handle dynamic structure: Django serializer might return {id: 1, text: 'A'} or just string
                    final int optionId = option is Map ? option['id'] : options.indexOf(option); 
                    final String optionText = option is Map ? option['text'] : option.toString();
                    
                    return _buildOption(optionId, optionText);
                  }),
                ],
              ),
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                 BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, -4), blurRadius: 10),
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
                  const SizedBox(width: 1), 
                  
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA82E2E), // Maroon
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    _currentQuestionIndex == _questions.length - 1 ? 'Selesai' : 'Selanjutnya',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(int optionId, String text) {
    // Current question's selected answer
    final currentQId = _questions[_currentQuestionIndex]['id'];
    final isSelected = _selectedAnswers[currentQId] == optionId;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswers[currentQId] = optionId;
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
                child: Container(
                   width: 12, height: 12,
                   decoration: BoxDecoration(
                     color: isSelected ? Colors.white : Colors.transparent,
                     shape: BoxShape.circle,
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

  List<dynamic> _getMockQuestions() {
    return [
      {
        'id': 1,
        'question_text': 'Apa yang dimaksud dengan "Affordance" dalam desain antarmuka pengguna?',
        'options': [
           {'id': 1, 'text': 'Kemampuan sebuah objek untuk memberi petunjuk cara penggunaannya'},
           {'id': 2, 'text': 'Konsistensi dalam penggunaan warna pada aplikasi'},
           {'id': 3, 'text': 'Kecepatan loading sebuah halaman web'},
        ]
      },
      {
        'id': 2,
        'question_text': 'Radio button dapat digunakan untuk menentukan?',
        'options': [
           {'id': 4, 'text': 'Jenis Kelamin'},
           {'id': 5, 'text': 'Alamat'},
           {'id': 6, 'text': 'Hobby'},
        ]
      }
    ];
  }
}
