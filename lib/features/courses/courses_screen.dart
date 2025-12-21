import 'package:flutter/material.dart';
import '../../core/models.dart';
import '../kelas/kelas_page.dart';

class CoursesScreen extends StatelessWidget {
  final List<Course> courses;

  const CoursesScreen({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        backgroundColor: const Color(0xFFB22222),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(course.title),
              subtitle: Text(course.description),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KelasPage(course: course),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}