import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilInfoItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isDate;

  const ProfilInfoItemWidget({
    super.key,
    required this.label,
    required this.value,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 16),
      ],
    );
  }
}
