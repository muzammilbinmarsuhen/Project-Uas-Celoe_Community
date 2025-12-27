import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTabs extends StatelessWidget {
  final TabController tabController;

  const ProfileTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        labelColor: const Color(0xFFA82E2E),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFFA82E2E),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3,
        labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
        tabs: const [
          Tab(text: 'ABOUT ME'),
          Tab(text: 'KELAS'),
          Tab(text: 'EDIT PROFILE'),
        ],
      ),
    );
  }
}
