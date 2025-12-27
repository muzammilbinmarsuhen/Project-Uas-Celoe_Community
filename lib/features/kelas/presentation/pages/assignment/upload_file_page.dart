import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dart:math';
import 'package:file_picker/file_picker.dart';

// Custom Dashed Painter
class DashedRect extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRect({this.color = Colors.grey, this.strokeWidth = 1.0, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(12)));

    Path dashPath = Path();

    double dashWidth = 10.0;
    double distance = 0.0;

    for (PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        dashPath.addPath(
          measurePath.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + gap;
      }
    }
    canvas.drawPath(dashPath, dashedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({super.key});

  @override
  State<UploadFilePage> createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  final List<PlatformFile> _uploadedFiles = [];
  bool _isLoading = false;

  Future<void> _pickFiles() async {
    setState(() => _isLoading = true);
    
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() {
          _uploadedFiles.addAll(result.files);
        });
      }
    } catch (e) {
       debugPrint('Error picking files: $e');
       if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Gagal mengambil file: $e'), backgroundColor: Colors.red),
         );
       }
    } finally {
       if (mounted) {
         setState(() => _isLoading = false);
       }
    }
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
          'Upload File',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(
            children: [
               // Upload Area
               GestureDetector(
                  onTap: _pickFiles,
                  child: CustomPaint(
                     painter: DashedRect(color: Colors.grey, strokeWidth: 2, gap: 5),
                     child: Container(
                        width: double.infinity,
                        height: 200,
                        alignment: Alignment.center,
                        child: _isLoading 
                          ? const CircularProgressIndicator(color: Color(0xFFA82E2E))
                          : Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                              Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey[400]),
                              const SizedBox(height: 12),
                              Text(
                                 'Klik untuk pilih file',
                                 style: GoogleFonts.poppins(color: Colors.grey[600], fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                 'Max 5MB, format PDF/DOC/IMG',
                                 style: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 12),
                              ),
                           ],
                        ),
                     ),
                  ),
               ),
               const SizedBox(height: 24),
               
               // File List with Animation
               Expanded(
                  child: _uploadedFiles.isEmpty
                     ? Center(child: Text('Belum ada file dipilih', style: GoogleFonts.poppins(color: Colors.grey[400])))
                     : ListView.builder(
                        itemCount: _uploadedFiles.length,
                        itemBuilder: (context, index) {
                           final file = _uploadedFiles[index];
                           final isPdf = file.extension == 'pdf';
                           final isImg = ['jpg', 'jpeg', 'png'].contains(file.extension);
                           
                           IconData icon = Icons.insert_drive_file;
                           Color iconColor = Colors.grey;
                           if (isPdf) { icon = Icons.picture_as_pdf; iconColor = Colors.red; }
                           else if (isImg) { icon = Icons.image; iconColor = Colors.purple; }
                           else if (['doc','docx'].contains(file.extension)) { icon = Icons.description; iconColor = Colors.blue; }

                           return TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.elasticOut,
                              builder: (context, value, child) {
                                 return Transform.scale(
                                    scale: value,
                                    child: child,
                                 );
                              },
                              child: Container(
                                 margin: const EdgeInsets.only(bottom: 12),
                                 padding: const EdgeInsets.all(12),
                                 decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                       BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))
                                    ]
                                 ),
                                 child: Row(
                                    children: [
                                       Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                                          child: Icon(icon, color: iconColor, size: 20),
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
                                       IconButton(
                                          icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                                          onPressed: () {
                                             setState(() {
                                                _uploadedFiles.removeAt(index);
                                             });
                                          },
                                       )
                                    ],
                                 ),
                              ),
                           );
                        },
                     )
               ),

               // Save Button
               SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                     onPressed: _uploadedFiles.isEmpty ? null : () {
                        if (mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('File berhasil diupload!'), backgroundColor: Colors.green)
                           );
                        }
                        Navigator.pop(context, _uploadedFiles);
                     },
                     style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA82E2E), // Maroon
                        disabledBackgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                     ),
                     child: Text('Simpan', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
               )
            ],
         ),
      ),
    );
  }
}

