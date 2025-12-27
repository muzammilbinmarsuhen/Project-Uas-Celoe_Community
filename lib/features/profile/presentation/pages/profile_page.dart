import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // Default values if data is missing
    final username = userData['username'] ?? 'Mahasiswa';
    final email = userData['email'] ?? 'student@celoe.com';
    final role = userData['role'] ?? 'Mahasiswa';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Gradient
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryMaroon, AppTheme.lightMaroon],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.primaryMaroon,
                        backgroundImage: userData['avatarUrl'] != null
                            ? NetworkImage(userData['avatarUrl'])
                            : null,
                        child: userData['avatarUrl'] == null
                            ? const Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      username,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      email,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                       decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12)
                       ),
                       child: Text(
                         role,
                         style: GoogleFonts.poppins(
                           fontSize: 12,
                           color: Colors.white,
                           fontWeight: FontWeight.w500
                         ),
                       ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Profile Menus
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildProfileCard(
                    context,
                    title: 'Edit Profil',
                    icon: Icons.edit_outlined,
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                    }
                  ),
                  _buildProfileCard(
                    context,
                    title: 'Ganti Password',
                    icon: Icons.lock_outline,
                    onTap: () {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur Ganti Password segera hadir')));
                    }
                  ),
                  _buildProfileCard(
                    context,
                    title: 'Pengaturan Aplikasi',
                    icon: Icons.settings_outlined,
                    onTap: () {}
                  ),
                  _buildProfileCard(
                    context,
                    title: 'Bantuan & Dukungan',
                    icon: Icons.help_outline,
                    onTap: () {}
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(
                    context,
                    title: 'Keluar',
                    icon: Icons.logout,
                    isLogout: true,
                    onTap: () {
                      // Navigate to Login and clear stack
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Versi 1.0.0',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap, bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout ? Colors.red.withValues(alpha: 0.1) : AppTheme.primaryMaroon.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: isLogout ? Colors.red : AppTheme.primaryMaroon),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}
