import 'package:flutter/material.dart';
import '../../../../core/models.dart';
import 'profile_info_item.dart';

class AboutTab extends StatelessWidget {
  final UserModel user;

  const AboutTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
             BoxShadow(
               color: Color.fromRGBO(0, 0, 0, 0.05),
               blurRadius: 10,
               offset: Offset(0, 4),
             ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileInfoItem(label: 'E-mail Address', value: user.email),
            ProfileInfoItem(label: 'Program Studi', value: user.studyProgram ?? '-'),
            ProfileInfoItem(label: 'Fakultas', value: user.faculty ?? '-'),
            
            const SizedBox(height: 16),
            const Text('Aktivitas Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            
            ProfileInfoItem(
              label: 'First access to site', 
              value: user.firstAccess != null 
                  ? user.firstAccess.toString() // Format nicer in real app
                  : '-',
            ),
            ProfileInfoItem(
              label: 'Last access to site', 
              value: user.lastAccess != null
                  ? user.lastAccess.toString() // Format nicer
                  : 'Now',
            ),
          ],
        ),
      ),
    );
  }
}
