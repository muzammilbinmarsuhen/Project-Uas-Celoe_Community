import 'dart:convert';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:http/http.dart' as http;
import '../models.dart';

class ApiService extends ChangeNotifier {
  // Use 127.0.0.1 for Web/iOS/Desktop, 10.0.2.2 for Android Emulator
  final String baseUrl = kIsWeb 
      ? 'http://127.0.0.1:8000/api' 
      : 'http://10.0.2.2:8000/api'; 
  String? _authToken;

  void setToken(String token) {
    _authToken = token;
    notifyListeners();
  }

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    if (_authToken != null) 'Authorization': 'Bearer $_authToken',
  };

  // --- Auth ---
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login/'),
        headers: headers,
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('Login failed: ${response.body}');
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> register(String username, String email, String password, String firstName, String lastName) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/'),
        headers: headers,
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
        }),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
         debugPrint('Register failed: ${response.body}');
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return null;
  }

  // --- Courses ---
  Future<List<Course>> getCourses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/classes/'), headers: headers);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => Course.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return []; 
  }

  Future<Course?> getCourseDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/classes/$id/'), headers: headers);
      if (response.statusCode == 200) {
        return Course.fromJson(json.decode(response.body));
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return null;
  }

  Future<List<dynamic>> getCourseTasksQuizzes(int courseId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/classes/$courseId/tasks-quizzes/'), headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return [];
  }

  // --- Materials ---
  Future<List<CourseMaterial>> getMaterials(int courseId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/classes/$courseId/materials/'), headers: headers);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => CourseMaterial.fromJson(json)).toList();
      }
    } catch (e) {
       debugPrint('API Error: $e');
    }
    return [];
  }

  Future<List<Attachment>> getAttachments(int materialId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/materials/$materialId/attachments/'), headers: headers);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => Attachment.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return [];
  }

  Future<List<dynamic>> getTasksQuizzes(int materialId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/materials/$materialId/tasks-quizzes/'), headers: headers);
      if (response.statusCode == 200) {
        // Returns list of mixed objects {type: 'quiz'|'assignment', ...}
        return json.decode(response.body) as List<dynamic>;
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return [];
  }

  // --- Assignments ---
  Future<bool> uploadAssignment(int assignmentId, String filePath) async {
    // Implementation would use http.MultipartRequest
    await Future.delayed(const Duration(seconds: 2)); // Mock delay
    return true; 
  }

  // --- Quizzes ---
  Future<Map<String, dynamic>?> startQuiz(int quizId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/quizzes/$quizId/start/'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return null;
  }

  // NOTE: This endpoint fetch question list, we don't have a specific model for Question yet in lms_models.dart, 
  // so we return List<dynamic> or we can add Question model. 
  // For now let's return dynamic to let UI handle.
  Future<List<dynamic>> getQuizQuestions(int quizId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/quizzes/$quizId/questions/'), headers: headers);
         if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return [];
  }

  Future<Map<String, dynamic>?> submitQuiz(int quizId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/quizzes/$quizId/submit/'),
        headers: headers,
        // Body usually contains answers, here handled by backend logic/mock
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // --- Notifications ---
  Future<List<NotificationItem>> getNotifications() async {
     try {
      final response = await http.get(Uri.parse('$baseUrl/notifications/'), headers: headers);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => NotificationItem.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('API Error: $e');
    }
    return [];
  }
}
