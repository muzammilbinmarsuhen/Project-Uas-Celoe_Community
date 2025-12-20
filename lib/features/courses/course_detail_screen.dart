import 'package:flutter/material.dart';
import '../../core/models.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course? course;

  const CourseDetailScreen({super.key, this.course});

  Course get _course => course ?? Course(
    id: '1',
    title: 'Introduction to Flutter',
    description: 'Learn the basics of Flutter development.',
    instructor: 'Jane Smith',
    progress: 0.6,
    modules: [
      Module(
        id: '1',
        title: 'Getting Started',
        type: 'video',
        contentUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isCompleted: true,
      ),
      Module(
        id: '2',
        title: 'Widgets Overview',
        type: 'text',
        contentUrl: 'This is the content for Widgets Overview.',
        isCompleted: false,
        quiz: Quiz(
          id: '1',
          questions: [
            QuizQuestion(
              id: '1',
              question: 'What is Flutter?',
              options: ['A framework', 'A language', 'An IDE', 'A database'],
              correctIndex: 0,
            ),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_course.title),
          backgroundColor: const Color(0xFFB22222),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Materials'),
              Tab(text: 'Assignments'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Materials Tab
            ListView.builder(
              itemCount: _course.modules.length,
              itemBuilder: (context, index) {
                final module = _course.modules[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      module.isCompleted ? Icons.check_circle : Icons.circle,
                      color: module.isCompleted ? Colors.green : Colors.grey,
                    ),
                    title: Text(module.title),
                    subtitle: Text(module.type),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to MaterialScreen
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialScreen(module: module)));
                    },
                  ),
                );
              },
            ),

            // Assignments Tab
            ListView.builder(
              itemCount: _course.modules.where((m) => m.quiz != null).length,
              itemBuilder: (context, index) {
                final quizModules = _course.modules.where((m) => m.quiz != null).toList();
                final module = quizModules[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.quiz),
                    title: Text(module.title),
                    subtitle: Text('Quiz'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to QuizScreen
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(quiz: module.quiz!)));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}