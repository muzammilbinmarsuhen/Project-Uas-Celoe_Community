import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../../data/dummy_course_data.dart';
import 'dart:math';

class AssignmentDetailPage extends StatefulWidget {
  const AssignmentDetailPage({super.key});

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {
  // Stats
  List<PlatformFile> _files = [];
  
  // Getter to fetch the shared task state directly
  // In a real app, this would be passed via constructor or provider
  TaskItem get _task => DummyCourseData.tasks.firstWhere((t) => t.id == 't1');

  bool get _isSubmitted => _task.isCompleted;

  void _navigateToUpload() async {
    final result = await Navigator.pushNamed(context, '/upload-file');
    if (result != null && result is List<PlatformFile>) {
       setState(() {
          _files = result;
       });
    }
  }

  void _submitAssignment() {
     showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
           title: Text("Serahkan Tugas?", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
           content: Text("Aksi ini tidak dapat dibatalkan. Pastikan file sudah benar.", style: GoogleFonts.poppins()),
           actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Batal")),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA82E2E)),
                 onPressed: () {
                    Navigator.pop(ctx);
                    setState(() {
                      // Update Shared State
                      final taskIndex = DummyCourseData.tasks.indexWhere((t) => t.id == 't1');
                      if (taskIndex != -1) {
                        // Create new TaskItem with updated status (immutable style copy)
                        final oldTask = DummyCourseData.tasks[taskIndex];
                        DummyCourseData.tasks[taskIndex] = TaskItem(
                          id: oldTask.id,
                          title: oldTask.title,
                          type: oldTask.type,
                          deadline: oldTask.deadline,
                          instruction: oldTask.instruction,
                          isCompleted: true, // Mark as completed
                        );
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text("Tugas berhasil diserahkan!"), backgroundColor: Colors.green)
                    );
                 }, 
                 child: const Text("Serahkan", style: TextStyle(color: Colors.white))
              )
           ],
        )
     );
  }


  String _formatSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA82E2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Tugas',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
         padding: const EdgeInsets.all(20),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                     return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                     );
                  },
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(
                           'Tugas 01 - UID Android Mobile Game',
                           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                           children: [
                              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(
                                 'Deadline: 30 Des 2025, 23:59',
                                 style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
                              ),
                           ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Status Card (Dynamic)
                        _buildStatusCard(),
                        
                        const SizedBox(height: 24),

                        // Main Logic Section (Description or File List)
                        if (_files.isNotEmpty) ...[
                           Text('File Tugas Anda', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                           const SizedBox(height: 12),
                           ..._files.map((file) => _buildFileItem(file)),
                           const SizedBox(height: 24),
                        ],

                        Text('Deskripsi Tugas', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text(
                           'Buatlah low-fidelity wireframe untuk aplikasi mobile game sederhana berbasis Android. Pastikan mencakup halaman menu utama, gameplay, dan settings.',
                           style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800], height: 1.6),
                        ),
                        const SizedBox(height: 24),
                        
                        Text('Ketentuan Pengerjaan', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                         _buildBulletPoint('Format file: PDF atau Figma Link'),
                         _buildBulletPoint('Ukuran maksimal: 5MB'),
                         _buildBulletPoint('Gunakan template yang sudah disediakan'),

                        const SizedBox(height: 40),
                        
                        // Action Button (Dynamic)
                        _buildActionButton(),
                     ],
                  ),
               )
            ],
         ),
      ),
    );
  }

  Widget _buildStatusCard() {
     Color bgColor;
     Color iconBgColor;
     Color textColor;
     IconData icon;
     String statusText;
     String statusLabel = 'Status Pengumpulan';

     if (_isSubmitted) {
        bgColor = Colors.blue.withValues(alpha: 0.1);
        iconBgColor = Colors.blue;
        textColor = Colors.blue[800]!;
        icon = Icons.check_circle_outline;
        statusText = 'Sudah Dikumpulkan';
     } else if (_files.isNotEmpty) {
        bgColor = Colors.green.withValues(alpha: 0.1);
        iconBgColor = Colors.green;
        textColor = Colors.green[800]!;
        icon = Icons.task_alt;
        statusText = 'Siap Diserahkan';
     } else {
        bgColor = Colors.orange.withValues(alpha: 0.1);
        iconBgColor = Colors.orange;
        textColor = Colors.orange[800]!;
        icon = Icons.hourglass_empty;
        statusText = 'Belum Dikirim';
     }

     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
           color: bgColor,
           borderRadius: BorderRadius.circular(12),
           border: Border.all(color: iconBgColor.withValues(alpha: 0.3))
        ),
        child: Row(
           children: [
              Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                 child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(statusLabel, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                    Text(statusText, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
                 ],
              )
           ],
        ),
     );
  }

  Widget _buildFileItem(PlatformFile file) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(12),
         border: Border.all(color: Colors.grey[200]!),
         boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 5, offset: const Offset(0, 2))
         ]
      ),
      child: Row(
         children: [
            Container(
               padding: const EdgeInsets.all(8),
               decoration: BoxDecoration(color: Colors.red[50], shape: BoxShape.circle),
               child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(file.name, style: GoogleFonts.poppins(fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                     Text(_formatSize(file.size), style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
                  ],
               ),
            ),
            if (!_isSubmitted)
            IconButton(
               icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
               onPressed: () {
                  setState(() {
                     _files.remove(file);
                  });
               },
            )
         ],
      ),
    );
  }

  Widget _buildActionButton() {
     if (_isSubmitted) {
        return SizedBox(
           width: double.infinity,
           child: OutlinedButton(
              onPressed: () {
                 // Logic to cancel submission
                 setState(() {
                      final taskIndex = DummyCourseData.tasks.indexWhere((t) => t.id == 't1');
                      if (taskIndex != -1) {
                         final oldTask = DummyCourseData.tasks[taskIndex];
                         DummyCourseData.tasks[taskIndex] = TaskItem(
                            id: oldTask.id,
                            title: oldTask.title,
                            type: oldTask.type,
                            deadline: oldTask.deadline,
                            instruction: oldTask.instruction,
                            isCompleted: false, // Reset to false
                         );
                      }
                 });
              },
              style: OutlinedButton.styleFrom(
                 padding: const EdgeInsets.symmetric(vertical: 16),
                 side: const BorderSide(color: Color(0xFFA82E2E)),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Batalkan Pengumpulan', style: GoogleFonts.poppins(color: const Color(0xFFA82E2E), fontWeight: FontWeight.bold)),
           ),
        );
     }

     if (_files.isNotEmpty) {
        return SizedBox(
           width: double.infinity,
           child: ElevatedButton(
              onPressed: _submitAssignment, // Action: Sumbit
              style: ElevatedButton.styleFrom(
                 backgroundColor: const Color(0xFF2E7D32), // Green for Submit
                 padding: const EdgeInsets.symmetric(vertical: 16),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                 elevation: 4
              ),
              child: Text('Serahkan', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
           ),
        );
     }

     // Default: Tambahkan Tugas
     return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
           onPressed: _navigateToUpload, 
           icon: const Icon(Icons.upload_file, color: Colors.white),
           label: Text('Tambahkan Tugas', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
           style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA82E2E),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4
           ),
        ),
     );
  }

  Widget _buildBulletPoint(String text) {
     return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Padding(
                 padding: EdgeInsets.only(top: 6),
                 child: Icon(Icons.circle, size: 6, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]))),
           ],
        ),
     );
  }
}
