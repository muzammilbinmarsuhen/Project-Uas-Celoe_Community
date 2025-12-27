import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../data/dummy_course_data.dart';

class TaskDetailPage extends StatefulWidget {
  final TaskItem task;
  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isQuiz = widget.task.type == TaskType.quiz;
    final color = isQuiz ? Colors.purple : Colors.orange;
    final icon = isQuiz ? Icons.quiz : Icons.article;
    final typeLabel = isQuiz ? 'QUIZ' : 'TUGAS';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA82E2E), // Maroon
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isQuiz ? 'Detail Quiz' : 'Detail Tugas',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 30),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      typeLabel,
                      style: GoogleFonts.poppins(color: color, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.task.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Deadline: ${DateFormat('dd MMMM yyyy, HH:mm').format(widget.task.deadline)}',
                    style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Expandable Instruction Card
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                   BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10, 
                    offset: const Offset(0, 4)
                   )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                           'Instruksi Pengerjaan',
                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
                         ),
                         IconButton(
                            icon: Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                            onPressed: () {
                               setState(() {
                                  _isExpanded = !_isExpanded;
                               });
                            },
                         )
                      ],
                   ),
                   if (_isExpanded) ...[
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                         widget.task.instruction, // From dummy data
                         style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, height: 1.6),
                      ),
                      const SizedBox(height: 20),
                      // Mock Submit Button 
                      SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(
                            onPressed: () {
                               if (isQuiz) {
                                  Navigator.pushNamed(context, '/quiz-overview');
                               } else {
                                  // For assignments, standard logic or nothing for now
                               }
                            }, 
                            style: ElevatedButton.styleFrom(
                               backgroundColor: const Color(0xFFA82E2E), // Maroon
                               padding: const EdgeInsets.symmetric(vertical: 14),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                               'Kerjakan Sekarang',
                               style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                         ),
                      )
                   ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
