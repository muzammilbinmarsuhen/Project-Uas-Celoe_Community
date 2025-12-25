import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KelasTabBarWidget extends StatelessWidget {
  final TabController controller;

  const KelasTabBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        padding: const EdgeInsets.all(4),
        indicator: BoxDecoration(
           border: const Border(
             bottom: BorderSide(color: Colors.black87, width: 3),
           ),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: "Materi"),
          Tab(text: "Tugas Dan Kuis"),
        ],
      ),
    );
  }
}
