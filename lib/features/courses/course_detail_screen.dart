import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models.dart';
import '../../core/data/dummy_data.dart'; // Use DummyData
import 'widgets/kelas_tab_bar_widget.dart';
import 'widgets/materi_card_widget.dart';
import 'widgets/tugas_kuis_card_widget.dart';
import 'widgets/empty_state_widget.dart';
import 'material_detail_screen.dart'; // Renamed
import 'assignment_detail_screen.dart'; // Renamed
import 'quiz/quiz_intro_page.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId; // Passed from course list
  final String title;
  final bool hideBackButton;

  const CourseDetailScreen({
    super.key, 
    required this.courseId, 
    required this.title,
    this.hideBackButton = false,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late Future<List<dynamic>> _dataFuture; // Removed API

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // USE DUMMY DATA DIRECTLY
    final materials = DummyData.materialsCourse1; 
    final tasksQuizzes = DummyData.tasksCourse1;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Red Header Background
          Container(
            height: 155, 
            decoration: const BoxDecoration(
              color: Color(0xFFA82E2E), // Merah LMS
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // 2. Main Content
          Positioned.fill(
            child: Column(
              children: [
                // Custom AppBar
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!widget.hideBackButton)
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back, color: Colors.white),
                            ),
                          ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              widget.title.toUpperCase(),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),

                // Floating TabBar
                KelasTabBarWidget(controller: _tabController),

                // Tab Views
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildMateriList(materials),
                        _buildTugasKuisList(tasksQuizzes),
                      ],
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

  Widget _buildMateriList(List<CourseMaterial> materials) {
    if (materials.isEmpty) {
      return const EmptyStateWidget(message: 'Tidak Ada Materi Hari Ini');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final item = materials[index];
        
        return TweenAnimationBuilder<double>(
           tween: Tween(begin: 0, end: 1),
           duration: Duration(milliseconds: 400 + (index * 100)),
           curve: Curves.easeOutQuart,
           builder: (context, value, child) {
             return MateriCardWidget(
               index: index,
               title: item.title,
               subtext: item.description, 
               isCompleted: item.completed, 
               animation: AlwaysStoppedAnimation(value),
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => MateriDetailPage(
                        materialId: item.id,
                        title: item.title,
                        description: item.description.isNotEmpty ? item.description : 'Tidak ada deskripsi.',
                     ),
                   ),
                 );
               },
             );
           }, 
        );
      },
    );
  }

  Widget _buildTugasKuisList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
       return const EmptyStateWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final itemMap = items[index];
        final id = itemMap['id'];
        final type = itemMap['type'];
        final title = itemMap['title'];
        final deadlineRaw = itemMap['deadline'];

        // Formatting logic
        String deadlineStr = 'Deadline: $deadlineRaw';

        return TweenAnimationBuilder<double>(
           tween: Tween(begin: 0, end: 1),
           duration: Duration(milliseconds: 400 + (index * 100)),
           curve: Curves.easeOutQuart,
           builder: (context, value, child) {
             return TugasKuisCardWidget(
               item: { 
                 'type': type == 'quiz' ? 'Quiz' : 'Tugas',
                 'title': title,
                 'deadline': deadlineStr,
                 'isCompleted': itemMap['status'] == 'completed',
               },
               animation: AlwaysStoppedAnimation(value),
               onTap: () {
                  if (type == 'quiz') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizIntroPage(quizId: id, title: title),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignmentDetailScreen(
                          assignmentId: id,
                          title: title,
                          deadline: deadlineStr,
                        ),
                      ),
                    );
                  }
               },
             );
           },
        );
      },
    );
  }
}