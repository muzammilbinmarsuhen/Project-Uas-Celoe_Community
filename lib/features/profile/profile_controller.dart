import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models.dart';
import '../../routes/app_routes.dart';

class ProfileState {
  final UserModel user;
  final bool isLoading;

  ProfileState({
    required this.user, 
    this.isLoading = false,
  });

  ProfileState copyWith({UserModel? user, bool? isLoading}) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    // Initial dummy state while loading
    final initialState = ProfileState(
      user: UserModel(
        id: 0,
        username: 'Loading...',
        email: '...',
      ),
      isLoading: true,
    );
    
    // Trigger load
    _loadUserFromPrefs();
    
    return initialState;
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? 'Mahasiswa';
    final email = prefs.getString('email') ?? 'student@celoe.com';
    // Ideally we would load full object from JSON string if we stored it
    // For now, we update the basic info we have
    
    state = state.copyWith(
      isLoading: false,
      user: UserModel(
        id: 1,
        username: username, 
        email: email,
        firstName: prefs.getString('firstName') ?? username.split(' ').first,
        lastName: prefs.getString('lastName') ?? (username.split(' ').length > 1 ? username.split(' ').last : ''),
        country: prefs.getString('country') ?? 'Indonesia',
        description: prefs.getString('description') ?? 'Mahasiswa Telkom University',
        faculty: prefs.getString('faculty') ?? 'Fakultas Informatika',
        studyProgram: prefs.getString('studyProgram') ?? 'S1 Rekayasa Perangkat Lunak',
        firstAccess: DateTime(2023, 8, 20),
        lastAccess: DateTime.now(),
        // Check if there is a saved photo path
        photoPath: prefs.getString('profile_photo_path'),
      ),
    );
  }

  void updateUser(UserModel newUser) {
    state = state.copyWith(user: newUser);
  }

  Future<bool> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        final newPath = pickedFile.path;
        
        // Update State
        state = state.copyWith(
            user: UserModel(
                id: state.user.id,
                username: state.user.username,
                email: state.user.email,
                avatarUrl: state.user.avatarUrl,
                photoPath: newPath, // Update local path
                firstName: state.user.firstName,
                lastName: state.user.lastName,
                country: state.user.country,
                description: state.user.description,
                faculty: state.user.faculty,
                studyProgram: state.user.studyProgram,
                firstAccess: state.user.firstAccess,
                lastAccess: state.user.lastAccess,
            )
        );

        // Persist Path
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_photo_path', newPath);
        return true;
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    return false;
  }

  // Web File Picker support if needed
  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.single.path != null) {
         final newPath = result.files.single.path!;
         state = state.copyWith(
            user: UserModel(
                id: state.user.id,
                username: state.user.username,
                email: state.user.email,
                avatarUrl: state.user.avatarUrl,
                photoPath: newPath,
                firstName: state.user.firstName,
                lastName: state.user.lastName,
                country: state.user.country,
                description: state.user.description,
                faculty: state.user.faculty,
                studyProgram: state.user.studyProgram,
                firstAccess: state.user.firstAccess,
                lastAccess: state.user.lastAccess,
            )
        );
         final prefs = await SharedPreferences.getInstance();
         await prefs.setString('profile_photo_path', newPath);
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  Future<void> saveProfile() async {
    // Simulate API save
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    
    // Save to prefs
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', state.user.username);
    await prefs.setString('firstName', state.user.firstName ?? '');
    await prefs.setString('lastName', state.user.lastName ?? '');
    await prefs.setString('country', state.user.country ?? '');
    await prefs.setString('description', state.user.description ?? '');
    await prefs.setString('faculty', state.user.faculty ?? '');
    await prefs.setString('studyProgram', state.user.studyProgram ?? '');
    // Note: photoPath is saved immediately upon selection
  }

  Future<void> logout(BuildContext context) async {
      // Clear persistence
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      if (context.mounted) {
          // Use named route ensuring we remove all previous routes
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      }
  }
}

final profileControllerProvider = NotifierProvider<ProfileController, ProfileState>(() {
  return ProfileController();
});
