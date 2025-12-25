import 'package:flutter/material.dart';
import '../../core/models.dart';
import '../../core/data/dummy_data.dart';
import 'course_detail_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  // Use Dummy Data
  final List<Course> _courses = DummyData.courses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Kelas Saya'),
        backgroundColor: const Color(0xFFA82E2E), // Merah LMS
        elevation: 0,
        centerTitle: true,
      ),
      body: _courses.isEmpty
          ? Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Icon(Icons.school_outlined, size: 64, color: Colors.grey),
                   const SizedBox(height: 16),
                   const Text('Belum ada kelas yang diambil'),
                 ],
               ),
            )
          : LayoutBuilder(
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
                  itemCount: _courses.length,
                  itemBuilder: (context, index) => _buildCourseCard(_courses[index]),
                );
              } else {
                // Mobile: List
                return ListView.builder(
                  itemCount: _courses.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => _buildCourseCard(_courses[index]),
                );
              }
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
              builder: (context) => CourseDetailScreen(
                courseId: course.id,
                title: course.title,
                hideBackButton: false, 
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
                    course.semester, // Changed from Semester + value
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: course.progress / 100, 
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFA82E2E)),
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
