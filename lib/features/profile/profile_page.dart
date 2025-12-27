import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/data/dummy_data.dart'; // For classes data
import 'profile_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_tabs.dart';
import 'widgets/about_tab.dart';
import 'widgets/kelas_tab.dart';
import 'widgets/edit_profile_tab.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleEditAvatar() {
    final controller = ref.read(profileControllerProvider.notifier);
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change Profile Photo',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                   if (kIsWeb) {
                      // On Web using file_picker often better but ProfileController has both methods
                      // Let's use pickImage(ImageSource.gallery) as it supports web too usually
                      controller.pickImage(ImageSource.gallery);
                   } else {
                      controller.pickImage(ImageSource.gallery);
                   }
                },
              ),
              if (kIsWeb) 
                 ListTile(
                  leading: const Icon(Icons.folder_open),
                  title: const Text('Choose File (Web)'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.pickFile();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch the profile controller state
    final user = ref.watch(profileControllerProvider).user;
    final profileImage = ref.watch(profileControllerProvider).profileImage;

    final name = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    final displayName = name.isNotEmpty ? name : user.username;
    
    ImageProvider? avatarImage;
    if (profileImage != null) {
       if (kIsWeb) {
         // File object on web might need handling, but Image.file works with standard html renderer? 
         // Actually kIsWeb + File (dart:io) is tricky. 
         // ProfileController uses 'File' from dart:io. 
         // For web, we might need bytes or XFile. 
         // Let's assume the controller handles it or we use NetworkImage for path if it's a blob url.
         // However, standard FileImage doesn't work on Web.
         // Let's check ProfileController implementation again.
         // It assigns _profileImage = File(pickedFile.path). on Web path is blob/...
         avatarImage = NetworkImage(profileImage.path); 
       } else {
         avatarImage = FileImage(profileImage);
       }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // 1. Header
          ProfileHeader(
            name: displayName,
            avatarUrl: user.avatarUrl ?? '',
            imageProvider: avatarImage,
            onEditAvatar: _handleEditAvatar,
          ),

          // 2. Tab Bar
          Transform.translate(
            offset: const Offset(0, -25), // Overlap header
            child: ProfileTabs(controller: _tabController),
          ),

          // 3. Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                 AboutTab(user: user),
                 KelasTab(classes: DummyData.classes),
                 EditProfileTab(user: user),
              ],
            ),
          ),
          
          // Logout Button (Bottom padding)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton.icon(
              onPressed: () {
                 // Implement logout
                 // ref.read(authControllerProvider.notifier).logout(); // If available
                 Navigator.pushReplacementNamed(context, '/login'); // Simple redirect for now
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
