class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
}

class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final double progress; // 0.0 to 1.0
  final List<Module> modules;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.progress,
    required this.modules,
  });
}

class Module {
  final String id;
  final String title;
  final String type; // 'video', 'text', 'quiz'
  final String contentUrl; // for video or text
  final bool isCompleted;
  final Quiz? quiz;

  Module({
    required this.id,
    required this.title,
    required this.type,
    required this.contentUrl,
    required this.isCompleted,
    this.quiz,
  });
}

class Quiz {
  final String id;
  final List<QuizQuestion> questions;

  Quiz({
    required this.id,
    required this.questions,
  });
}

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class Announcement {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });
}