import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - will be replaced with real data later
    final User currentUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      avatarUrl: 'https://via.placeholder.com/150',
    );

    final List<Announcement> announcements = [
      Announcement(
        id: '1',
        title: 'Welcome to CeLOE',
        content: 'Start your learning journey today!',
        date: DateTime.now(),
      ),
      Announcement(
        id: '2',
        title: 'New Course Available',
        content: 'Check out our latest Flutter course.',
        date: DateTime.now(),
      ),
    ];

    final List<Course> activeCourses = [
      Course(
        id: '1',
        title: 'Introduction to Flutter',
        description: 'Learn the basics of Flutter development.',
        instructor: 'Jane Smith',
        progress: 0.6,
        modules: [],
      ),
      Course(
        id: '2',
        title: 'Advanced Dart',
        description: 'Deep dive into Dart programming.',
        instructor: 'Bob Johnson',
        progress: 0.3,
        modules: [],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFFB22222),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(currentUser.avatarUrl),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Announcements Slider
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Announcements',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFFB22222),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: announcements.map((announcement) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(announcement.content),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Active Courses
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Active Courses',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFFB22222),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activeCourses.length,
              itemBuilder: (context, index) {
                final course = activeCourses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(course.description),
                        const SizedBox(height: 8),
                        Text('Instructor: ${course.instructor}'),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: course.progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFB22222),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('${(course.progress * 100).toInt()}% Complete'),
                      ],
                    ),
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