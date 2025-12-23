
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/models/lms_models.dart';
import '../../core/services/api_service.dart';
import 'video_materi_page.dart';
import 'tugas_detail_page.dart';
import 'quiz/quiz_intro_page.dart';

class MateriDetailPage extends StatefulWidget {
  final int materialId;
  final String title;
  final String description;

  const MateriDetailPage({
    super.key, 
    required this.materialId,
    required this.title,
    this.description = '',
  });

  @override
  State<MateriDetailPage> createState() => _MateriDetailPageState();
}

class _MateriDetailPageState extends State<MateriDetailPage> with SingleTickerProviderStateMixin {
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
      api.getAttachments(widget.materialId),
      api.getTasksQuizzes(widget.materialId),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Materi',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFB22222)));
          }

          final attachments = snapshot.data?[0] as List<Attachment>? ?? [];
          final tasks = snapshot.data?[1] as List<dynamic>? ?? [];

          return Column(
            children: [
              // Header Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description.isNotEmpty ? widget.description : 'Tidak ada deskripsi.',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),

              // TabBar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color(0xFFB22222),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  tabs: const [
                    Tab(text: 'Lampiran Materi'),
                    Tab(text: 'Tugas & Kuis'),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),

              // Tab View
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAttachmentsTab(attachments),
                    _buildTasksTab(tasks),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAttachmentsTab(List<Attachment> attachments) {
    if (attachments.isEmpty) {
      return const Center(child: Text("Tidak ada lampiran."));
    }
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        final item = attachments[index];
        IconData icon;
        Color color;
        
        switch (item.type) {
          case 'video': icon = Icons.play_circle_fill; color = Colors.red; break;
          case 'pdf': icon = Icons.picture_as_pdf; color = Colors.orange; break;
          case 'url': icon = Icons.link; color = Colors.blue; break;
          case 'meeting': icon = Icons.video_camera_front; color = Colors.purple; break;
          default: icon = Icons.insert_drive_file; color = Colors.grey;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: ListTile(
            leading: Icon(icon, color: color, size: 32),
            title: Text(item.title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            subtitle: Text(item.type.toUpperCase(), style: GoogleFonts.poppins(fontSize: 12)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
               if (item.type == 'video') {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoMateriPage()));
               }
               // Add handlers for other types
            },
          ),
        );
      },
    );
  }

  Widget _buildTasksTab(List<dynamic> tasks) {
    if (tasks.isEmpty) {
       return const Center(child: Text("Tidak ada tugas/kuis."));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final item = tasks[index];
        final type = item['type'];
        final title = item['title'];
        final id = item['id']; // Extract ID
        final deadline = item['deadline'] ?? '-';

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: ListTile(
            leading: Icon(
              type == 'quiz' ? Icons.timer : Icons.assignment,
              color: const Color(0xFFB22222),
            ),
            title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            subtitle: Text(type == 'quiz' ? 'Kuis' : 'Tugas', style: GoogleFonts.poppins(fontSize: 12)),
            trailing: const Icon(Icons.chevron_right),
             onTap: () {
                if (type == 'quiz') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => QuizIntroPage(quizId: id, title: title)));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => TugasDetailPage(assignmentId: id, title: title, deadline: deadline)));
                }
             },
          ),
        );
      },
    );
  }
}
