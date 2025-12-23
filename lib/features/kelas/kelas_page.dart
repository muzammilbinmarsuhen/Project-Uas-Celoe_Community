import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/models/lms_models.dart';
import '../../core/services/api_service.dart';
import 'widgets/kelas_tab_bar_widget.dart';
import 'widgets/materi_card_widget.dart';
import 'widgets/tugas_kuis_card_widget.dart';
import 'widgets/empty_state_widget.dart';
import 'materi_detail_page.dart';
import 'tugas_detail_page.dart';
import 'quiz/quiz_intro_page.dart';

class KelasPage extends StatefulWidget {
  final int courseId; // Passed from course list
  final String title;
  final bool hideBackButton;

  const KelasPage({
    super.key, 
    required this.courseId, 
    required this.title,
    this.hideBackButton = false,
  });

  @override
  State<KelasPage> createState() => _KelasPageState();
}

class _KelasPageState extends State<KelasPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _dataFuture = _fetchData();
  }

  Future<List<dynamic>> _fetchData() async {
    final api = Provider.of<ApiService>(context, listen: false);
    return Future.wait([
      api.getCourseDetail(widget.courseId),
      api.getMaterials(widget.courseId),
      api.getCourseTasksQuizzes(widget.courseId),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFA82E2E)));
          }

          final course = snapshot.data?[0] as Course?;
          final materials = snapshot.data?[1] as List<CourseMaterial>? ?? [];
          final tasksQuizzes = snapshot.data?[2] as List<dynamic>? ?? [];
          
          // Fallback if course info fails
          final displayTitle = course != null ? '${course.title} [ADY]' : widget.title;

          // Mock data if everything empty (Robust Fallback)
          final finalMaterials = materials.isNotEmpty ? materials : _getMockMaterials();
          final finalTasks = tasksQuizzes.isNotEmpty ? tasksQuizzes : _getMockTasks();

          return Stack(
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
                                  displayTitle.toUpperCase(),
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
                            _buildMateriList(finalMaterials),
                            _buildTugasKuisList(finalTasks),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
               subtext: '${item.attachments.length} Files', 
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

  Widget _buildTugasKuisList(List<dynamic> items) {
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
        String deadlineStr = '';
        if (type == 'quiz') {
           deadlineStr = 'Deadline: $deadlineRaw'; 
        } else {
           deadlineStr = 'Deadline: $deadlineRaw';
        }

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
                        builder: (context) => TugasDetailPage(
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
  
  List<CourseMaterial> _getMockMaterials() {
    return [
      CourseMaterial(
        id: 1, 
        title: '01 - Pengantar User Interface Design', 
        description: '3 URLs, 2 Files, 3 Interactive Content', 
        completed: false,
        attachments: [
          Attachment(id: 1, title: 'Slide', type: 'pdf', url: '', completed: false),
        ]
      ),
      CourseMaterial(id: 2, title: '02 - Konsep User Interface Design', description: '2 URLs, 1 Kuis, 3 Files, 1 Tugas', completed: true, attachments: []),
      CourseMaterial(id: 3, title: '03 - Interaksi pada User Interface Design', description: '3 URLs, 2 Files, 3 Interactive Content', completed: false, attachments: []),
      CourseMaterial(id: 4, title: '04 - Ethnographic Observation', description: '3 URLs, 2 Files, 3 Interactive Content', completed: false, attachments: []),
    ];
  }

  List<dynamic> _getMockTasks() {
    return [
      {
        'id': 1,
        'type': 'assignment',
        'title': 'Tugas 01 - UID Android Mobile Game',
        'deadline': DateTime.now().add(const Duration(days: 3)).toString(),
        'status': 'not_started',
      },
      {
        'id': 2,
        'type': 'quiz',
        'title': 'Quiz Review 01',
        'deadline': DateTime.now().add(const Duration(days: 1)).toString(),
        'status': 'not_started',
      },
    ];
  }
}
