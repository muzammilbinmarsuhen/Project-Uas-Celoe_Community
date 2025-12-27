import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../core/models.dart';

class ProfileState {
  final UserModel user;
  final File? profileImage;

  ProfileState({
    required this.user, 
    this.profileImage
  });

  ProfileState copyWith({UserModel? user, File? profileImage}) {
    return ProfileState(
      user: user ?? this.user,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    return ProfileState(
      user: UserModel(
        id: 1,
        username: 'johndoe',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        country: 'Indonesia',
        description: 'A passionate developer.',
        faculty: 'Fakultas Informatika',
        studyProgram: 'S1 Rekayasa Perangkat Lunak',
        firstAccess: DateTime(2023, 1, 1),
        lastAccess: DateTime.now(),
      ),
    );
  }

  void updateUser(UserModel newUser) {
    state = state.copyWith(user: newUser);
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        state = state.copyWith(profileImage: File(pickedFile.path));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.single.path != null) {
        state = state.copyWith(profileImage: File(result.files.single.path!));
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  void saveProfile() {
    debugPrint('Profile saved: ${state.user.toJson()}');
  }
}

final profileControllerProvider = NotifierProvider<ProfileController, ProfileState>(() {
  return ProfileController();
});
