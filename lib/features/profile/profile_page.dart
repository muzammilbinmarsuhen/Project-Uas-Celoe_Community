import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_tabs.dart';
import 'widgets/about_tab.dart';
import 'widgets/kelas_tab.dart';
import 'widgets/profile_form.dart';
import '../kelas/kelas_controller.dart'; 

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
              const Text(
                'Ubah Foto Profil',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil Foto'),
                onTap: () async {
                  Navigator.pop(context);
                  final success = await controller.pickImage(ImageSource.camera);
                  if (success && context.mounted) {
                     ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Foto profile diperbarui!'), backgroundColor: Colors.green),
                     );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  final success = await controller.pickImage(ImageSource.gallery);
                  if (success && context.mounted) {
                     ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Foto profile diperbarui!'), backgroundColor: Colors.green),
                     );
                  }
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
    // Watch state
    final profileState = ref.watch(profileControllerProvider);
    final user = profileState.user;
    
    // Watch classes for KelasTab
    final classesAsync = ref.watch(kelasControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Consistent background
      body: Stack(
        children: [
          Column(
             children: [
                // 1. Header (Fixed Height portion)
                ProfileHeader(
                  user: user,
                  onEditAvatar: _handleEditAvatar, 
                  onBack: () => Navigator.of(context).pop(),
                ),
                
                // 2. Tab Views (Expanded)
                Expanded(
                  child: Padding(
                     padding: const EdgeInsets.only(top: 25), // Space for floating tabs
                     child: TabBarView(
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        children: [
                           // ABOUT ME
                           AboutTab(user: user),
                           
                           // KELAS SAYA
                           classesAsync.when(
                              data: (data) => KelasTab(classes: data),
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, st) => Center(child: Text('Error loading classes: $e')),
                           ),
                           
                           // EDIT PROFILE
                           ProfileForm(
                              user: user, 
                              onSave: (updatedUser) {
                                 ref.read(profileControllerProvider.notifier).updateUser(updatedUser);
                                 ref.read(profileControllerProvider.notifier).saveProfile();
                              }
                           ),
                        ],
                     ),
                  ),
                ),
             ],
          ),
          
          // 3. Floating Tabs (Positoned)
          Positioned(
             top: 230, // Adjust based on Header height (approx 280-300 total header visual)
             left: 0, 
             right: 0,
             child: ProfileTabs(tabController: _tabController),
          ),
          
          // Loading Overlay
          if (profileState.isLoading)
             Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: const Center(child: CircularProgressIndicator()),
             ),
        ],
      ),
    );
  }
}
