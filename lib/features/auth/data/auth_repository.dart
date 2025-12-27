import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<void> login(String email, String password) async {
    // Simulate login - in real app, this would call an API
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    await prefs.setString('username', email.split('@')[0]); // Simple username from email
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (!isLoggedIn) return null;

    final email = prefs.getString('email');
    final username = prefs.getString('username');
    final avatarUrl = prefs.getString('avatarUrl');

    if (email != null && username != null) {
      return {
        'username': username,
        'email': email,
        'avatarUrl': avatarUrl,
      };
    }
    return null;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
