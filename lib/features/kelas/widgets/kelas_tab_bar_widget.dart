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
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
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
