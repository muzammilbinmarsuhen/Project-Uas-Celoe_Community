import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<bool> login(String username, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real mock, we might check stored credentials, but for "bypass" mode 
    // we often just allow login if fields are valid. 
    // However, to be consistent with "register then login", let's check if we have a user.
    // For simplicity requested ("hapus backend biar bisa register dan login"), 
    // we'll just succeed and ensure we set the session data.
    
    final prefs = await SharedPreferences.getInstance();
    
    // If we have registered before, we might want to use that data.
    // If not, we might default to the username provided at login.
    // Let's assume the user just registered or we are just mocking a successful login.
    
    await prefs.setBool('isLoggedIn', true);
    
    // If we haven't stored these from register yet, store them now based on login input
    // (This is a fallback if they login without registering in this session)
    if (!prefs.containsKey('username')) {
       await prefs.setString('username', username);
       await prefs.setString('email', '$username@example.com');
       await prefs.setString('firstName', username);
       await prefs.setString('lastName', '');
    }
    
    return true;
  }
  
  Future<bool> register(String username, String email, String password, String firstName, String lastName) async {
     await Future.delayed(const Duration(seconds: 1));
     
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('username', username);
     await prefs.setString('email', email);
     await prefs.setString('firstName', firstName);
     await prefs.setString('lastName', lastName);
     // We don't set isLoggedIn here usually, we let them login after register, 
     // or we can auto-login. The RegisterPage logic handles navigation to Login.
     
     return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (!isLoggedIn) return null;

    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final firstName = prefs.getString('firstName');
    final lastName = prefs.getString('lastName');
    final avatarUrl = prefs.getString('avatarUrl');

    if (username != null) {
      return {
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'avatarUrl': avatarUrl,
      };
    }
    return null;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
