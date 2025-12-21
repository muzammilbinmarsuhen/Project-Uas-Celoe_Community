import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KelasTabBarWidget extends StatelessWidget {
  final TabController controller;

  const KelasTabBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.black87, width: 3),
          insets: EdgeInsets.symmetric(horizontal: 40),
        ),
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Materi'),
          Tab(text: 'Tugas Dan Kuis'),
        ],
      ),
    );
  }
}
