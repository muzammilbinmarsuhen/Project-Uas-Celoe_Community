import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../data/dummy_course_data.dart';

class AssignmentTab extends StatefulWidget {
  const AssignmentTab({super.key});

  @override
  State<AssignmentTab> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends State<AssignmentTab> {
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
      if (_selectedIds.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _enterSelectionMode(String id) {
    setState(() {
      _isSelectionMode = true;
      _selectedIds.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = DummyCourseData.tasks;

    return Column(
      children: [
        if (_isSelectionMode)
           Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_selectedIds.length} Dipilih', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => setState(() {
                    _isSelectionMode = false;
                    _selectedIds.clear();
                  }),
                  child: Text('Batal', style: GoogleFonts.poppins(color: Colors.red)),
                )
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return _buildTaskCard(context, tasks[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, TaskItem item) {
    final isQuiz = item.type == TaskType.quiz;
    final color = isQuiz ? Colors.purple : Colors.orange;
    final icon = isQuiz ? Icons.quiz : Icons.article;
    final label = isQuiz ? 'Quiz' : 'Tugas';
    final isSelected = _selectedIds.contains(item.id);

    return GestureDetector(
      onTap: () {
         if (_isSelectionMode) {
           _toggleSelection(item.id);
         } else {
            if (isQuiz) {
               Navigator.pushNamed(context, '/task-detail', arguments: item);
            } else {
               Navigator.pushNamed(context, '/assignment-detail');
            }
         }
      },
      onLongPress: () => _enterSelectionMode(item.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: color, width: 1.5) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                         border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
                         borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        label.toUpperCase(),
                        style: GoogleFonts.poppins(color: color, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                         const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                         const SizedBox(width: 4),
                         Text(
                           'Deadline: ${DateFormat('dd MMM yyyy').format(item.deadline)}',
                           style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
                         ),
                      ],
                    )
                  ],
                ),
              ),
              
              if (_isSelectionMode)
                Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank, 
                  color: isSelected ? color : Colors.grey
                )
            ],
          ),
        ),
      ),
    );
  }
}
