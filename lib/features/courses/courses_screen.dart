import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/lms_models.dart';
import '../../core/services/api_service.dart';
import '../kelas/kelas_page.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = Provider.of<ApiService>(context, listen: false).getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Kelas Saya'),
        backgroundColor: const Color(0xFFB22222), // Merah LMS
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFB22222)));
          }
          
          final courses = snapshot.data ?? [];

          // Mock data fallback if API returns empty (for demo purposes if backend not running)
          // In production, you might just show empty state. 
          // However, user requested "All menus connect", so let's rely on API or robust mock in ApiService.
          // ApiService currently returns [] on error.
          
          if (courses.isEmpty) {
             return Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Icon(Icons.school_outlined, size: 64, color: Colors.grey),
                   const SizedBox(height: 16),
                   const Text('Belum ada kelas yang diambil'),
                   const SizedBox(height: 16),
                   ElevatedButton(
                     onPressed: () {
                       setState(() {
                         _coursesFuture = Provider.of<ApiService>(context, listen: false).getCourses();
                       });
                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: const Color(0xFFB22222)
                     ),
                     child: const Text('Refresh'),
                   )
                 ],
               ),
             );
          }

          // Responsive Layout
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Tablet/Web: Grid
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, 
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) => _buildCourseCard(courses[index]),
                );
              } else {
                // Mobile: List
                return ListView.builder(
                  itemCount: courses.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => _buildCourseCard(courses[index]),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KelasPage(
                courseId: course.id,
                title: course.title,
                hideBackButton: false, // Showing back button since we are navigating from List
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: course.thumbnail != null && course.thumbnail!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(course.thumbnail!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: course.thumbnail == null || course.thumbnail!.isEmpty
                  ? Center(child: Icon(Icons.image, color: Colors.grey[500], size: 40))
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Semester ${course.semester}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: course.progress / 100, // Assuming 0-100 from API or 0-1
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFB22222)),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${(course.progress).toInt()}%',
                       style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
