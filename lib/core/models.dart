
class User {
  final int id;
  final String username;
  final String email;
  final String? avatarUrl;

  User({required this.id, required this.username, required this.email, this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }
}

class Attachment {
  final int id;
  final String type; // video, pdf, url, meeting
  final String title;
  final String url;
  final bool completed;

  Attachment({required this.id, required this.type, required this.title, required this.url, required this.completed});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      url: json['url'],
      completed: json['completed'] ?? false,
    );
  }
}

class CourseMaterial {
  final int id;
  final String title;
  final String description;
  final bool completed;
  final List<Attachment> attachments; // Optional: May be empty if fetched from list endpoint

  CourseMaterial({required this.id, required this.title, required this.description, required this.completed, required this.attachments});

  factory CourseMaterial.fromJson(Map<String, dynamic> json) {
    return CourseMaterial(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      completed: json['completed'] ?? false,
      attachments: json['attachments'] != null 
          ? (json['attachments'] as List).map((i) => Attachment.fromJson(i)).toList() 
          : [],
    );
  }
}


class Assignment {
  final int id;
  final String title;
  final String description;
  final DateTime deadline;
  final String status; // not_started, in_progress, completed
  final double? score;

  Assignment({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.deadline,
    required this.status,
    this.score
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      deadline: DateTime.parse(json['deadline']),
      status: json['status'] ?? 'not_started',
      score: json['score'] != null ? (json['score'] as num).toDouble() : null,
    );
  }
}

class Quiz {
  final int id;
  final String title;
  final int durationMinutes;
  final DateTime deadline;
  final String description;

  Quiz({required this.id, required this.title, required this.durationMinutes, required this.deadline, required this.description});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      durationMinutes: json['duration_minutes'],
      deadline: DateTime.parse(json['deadline']),
      description: json['description'] ?? '',
    );
  }
}

class Course {
  final int id;
  final String title;
  final String semester;
  final double progress;
  final String? thumbnail;
  // Previously we nested meetings/assignments/quizzes. 
  // Per new spec, these are fetched separately usually, but for Detail Page efficient loading we might still map them if API provides.
  // Django serializer 'CourseSerializer' currently sends light data. 
  // We need to fetch materials separately or adjust 'Course' model on frontend to be light.
  // Let's keep it flexible.
  
  Course({
    required this.id, 
    required this.title, 
    required this.semester, 
    required this.progress,
    this.thumbnail,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      semester: json['semester'] ?? '2021/2',
      progress: json['progress'] ?? 0.0,
      thumbnail: json['thumbnail'],
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String link;
  final bool isRead;
  final String createdAt;
  final int? relatedId;
  final String? relatedType; // 'quiz', 'assignment', 'material'

  NotificationItem({
    required this.title, 
    required this.message, 
    required this.link, 
    required this.isRead, 
    required this.createdAt,
    this.relatedId,
    this.relatedType,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'],
      message: json['message'],
      link: json['link'] ?? '',
      isRead: json['is_read'],
      createdAt: json['created_at'],
      relatedId: json['related_id'], 
      relatedType: json['related_type'],
    );
  }
}
