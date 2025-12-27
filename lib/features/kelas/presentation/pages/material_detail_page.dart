import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/dummy_course_data.dart';

class MaterialDetailPage extends StatefulWidget {
  final MaterialItem material;
  const MaterialDetailPage({super.key, required this.material});

  @override
  State<MaterialDetailPage> createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends State<MaterialDetailPage> with SingleTickerProviderStateMixin {
  late TabController _internalTabController;

  @override
  void initState() {
    super.initState();
    _internalTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _internalTabController.dispose();
    super.dispose();
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
            'Detail Materi',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
         ),
         elevation: 0,
      ),
      body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Container(
               padding: const EdgeInsets.all(20),
               color: Colors.white,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                        widget.material.title,
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(height: 8),
                     Text(
                        widget.material.description,
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
                     ),
                  ],
               ),
            ),
            const SizedBox(height: 10),
            Container(
               color: Colors.white,
               child: TabBar(
                  controller: _internalTabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFFA82E2E), // Maroon
                  tabs: const [
                     Tab(text: 'Lampiran Materi'),
                     Tab(text: 'Tugas dan Kuis'),
                  ],
               ),
            ),
            Expanded(
               child: TabBarView(
                  controller: _internalTabController,
                  children: [
                     _buildAttachmentList(),
                     _buildEmptyTaskState(),
                  ],
               ),
            ),
         ],
      ),
    );
  }

  Widget _buildAttachmentList() {
     if (widget.material.attachments.isEmpty) {
        return Center(child: Text("Tidak ada lampiran", style: GoogleFonts.poppins()));
     }
     
     return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: widget.material.attachments.length,
        itemBuilder: (context, index) {
           final item = widget.material.attachments[index];
           IconData icon = Icons.link;
           Color color = Colors.blue;
           if (item.type == 'pdf') { icon = Icons.picture_as_pdf; color = Colors.red; }
           if (item.type == 'video') { icon = Icons.videocam; color = Colors.purple; }

           return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                 children: [
                    Container(
                       padding: const EdgeInsets.all(8),
                       decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
                       child: Icon(icon, color: color, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                       child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(item.title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                             Text(item.type.toUpperCase(), style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10)),
                          ],
                       ),
                    ),
                    const Icon(Icons.download_rounded, color: Colors.grey),
                 ],
              ),
           );
        },
     );
  }

  Widget _buildEmptyTaskState() {
     return Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Icon(Icons.assignment_turned_in_outlined, size: 80, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                 'Tidak Ada Tugas Dan Kuis Hari Ini',
                 style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
              ),
           ],
        ),
     );
  }
}
