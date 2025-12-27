import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../../../data/dummy_course_data.dart';

class QuizQuestionPage extends StatefulWidget {
  const QuizQuestionPage({super.key});

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int _currentIndex = 0;
  // Map to store selected option ID for each question index
  final Map<int, String> _selectedAnswers = {};
  
  late Timer _timer;
  int _remainingSeconds = 900; // 15 minutes

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final questions = DummyCourseData.quizQuestions;
    final currentQuestion = questions[_currentIndex];

    // Mocking 15 indicators as requested, even if we assume 5 questions for now to avoid crash
    final indicatorCount = 15;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xffB74B4B),
        leading: Container(), // No back button during quiz usually, or custom warn
        leadingWidth: 0,
        title: Text(
          'Quiz Review 1',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
             margin: const EdgeInsets.only(right: 16),
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
             decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20)
             ),
             child: Row(
               children: [
                  const Icon(Icons.timer, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(_formatTime(_remainingSeconds), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
               ],
             ),
          )
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Question Indicators
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            height: 70, // Fixed height
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: indicatorCount,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isCurrent = index == _currentIndex;
                // Mock logic: if index within real questions range, check selection, else white
                bool isAnswered = false;
                if (index < questions.length) {
                   isAnswered = _selectedAnswers.containsKey(index);
                }
                
                Color bgColor = Colors.white;
                Color borderColor = Colors.grey[300]!;
                Color textColor = Colors.grey[600]!;

                if (isAnswered) {
                   bgColor = const Color(0xFFE8F5E9); // Light Green
                   borderColor = Colors.green;
                   textColor = Colors.green;
                }
                
                if (isCurrent) {
                   borderColor = const Color(0xffB74B4B);
                   textColor = const Color(0xffB74B4B);
                   // Thick border handled below
                }

                return GestureDetector(
                   onTap: () {
                      if (index < questions.length) {
                         setState(() {
                            _currentIndex = index;
                         });
                      }
                   },
                   child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      decoration: BoxDecoration(
                         color: bgColor,
                         shape: BoxShape.circle,
                         border: Border.all(
                            color: borderColor,
                            width: isCurrent ? 2.5 : 1.0
                         )
                      ),
                      child: Center(
                         child: Text(
                            '${index + 1}',
                            style: GoogleFonts.poppins(
                               color: textColor,
                               fontWeight: FontWeight.w600,
                               fontSize: 13
                            ),
                         ),
                      ),
                   ),
                );
              },
            ),
          ),
          
          Expanded(
             child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text(
                         'Soal Nomor ${_currentIndex + 1} / ${questions.length}',
                         style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 12),
                      Text(
                         currentQuestion.text,
                         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                      const SizedBox(height: 24),
                      
                      // Options
                      ...currentQuestion.options.map((option) {
                         final isSelected = _selectedAnswers[_currentIndex] == option.id;
                         return GestureDetector(
                            onTap: () {
                               setState(() {
                                  _selectedAnswers[_currentIndex] = option.id;
                               });
                            },
                            child: AnimatedContainer(
                               duration: const Duration(milliseconds: 200),
                               margin: const EdgeInsets.only(bottom: 12),
                               padding: const EdgeInsets.all(16),
                               decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFFFFF0F0) : Colors.white, // Pinkish if selected
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                     color: isSelected ? const Color(0xffB74B4B) : Colors.grey[200]!
                                  ),
                                  boxShadow: [
                                     BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2)
                                     )
                                  ]
                               ),
                               child: Row(
                                  children: [
                                     Container(
                                        width: 30, height: 30,
                                        decoration: BoxDecoration(
                                           color: isSelected ? const Color(0xffB74B4B) : Colors.grey[100],
                                           shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                           child: Text(
                                              option.id,
                                              style: GoogleFonts.poppins(
                                                 color: isSelected ? Colors.white : Colors.grey[700],
                                                 fontWeight: FontWeight.bold
                                              ),
                                           ),
                                        ),
                                     ),
                                     const SizedBox(width: 16),
                                     Expanded(
                                        child: Text(
                                           option.text,
                                           style: GoogleFonts.poppins(
                                              color: isSelected ? const Color(0xffB74B4B) : Colors.black87,
                                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal
                                           ),
                                        ),
                                     )
                                  ],
                               ),
                            ),
                         );
                      }),
                   ],
                ),
             ),
          ),
          
          // Bottom Nav Buttons
          Container(
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                   BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))
                ]
             ),
             child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   if (_currentIndex > 0)
                      OutlinedButton.icon(
                         onPressed: () {
                            setState(() {
                               _currentIndex--;
                            });
                         },
                         icon: const Icon(Icons.arrow_back, size: 16, color: Colors.grey),
                         label: Text('Sebelumnya', style: GoogleFonts.poppins(color: Colors.grey[700])),
                         style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                         ),
                      )
                   else
                      const SizedBox(width: 10), // Spacer

                   if (_currentIndex < questions.length - 1)
                      ElevatedButton.icon(
                         onPressed: () {
                            setState(() {
                               _currentIndex++;
                            });
                         },
                         icon: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                         label: Text('Selanjutnya', style: GoogleFonts.poppins(color: Colors.white)),
                         style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffB74B4B),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                         ),
                      )
                   else
                      ElevatedButton.icon(
                         onPressed: () {
                             // Confirm Finish
                             Navigator.pushReplacementNamed(context, '/quiz-review'); // Go to review
                         },
                         icon: const Icon(Icons.check_circle, size: 16, color: Colors.white),
                         label: Text('Selesai', style: GoogleFonts.poppins(color: Colors.white)),
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Green for finish
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                         ),
                      ),
                ],
             ),
          )
        ],
      ),
    );
  }
}
