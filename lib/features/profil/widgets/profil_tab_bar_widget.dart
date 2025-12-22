import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilTabBarWidget extends StatelessWidget {
  final TabController controller;

  const ProfilTabBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.black87, width: 3),
          insets: EdgeInsets.symmetric(horizontal: 20),
        ),
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const [
          Tab(text: 'About Me'),
          Tab(text: 'Kelas'),
          Tab(text: 'Edit Profile'),
        ],
      ),
    );
  }
}
