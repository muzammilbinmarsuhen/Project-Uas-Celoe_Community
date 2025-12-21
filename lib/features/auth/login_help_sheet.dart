import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginHelpSheet extends StatefulWidget {
  const LoginHelpSheet({super.key});

  @override
  State<LoginHelpSheet> createState() => _LoginHelpSheetState();
}

class _LoginHelpSheetState extends State<LoginHelpSheet> {
  bool _isIndonesian = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Language Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLanguageOption('ID', true),
              const SizedBox(width: 40),
              _buildLanguageOption('EN', false),
            ],
          ),
          const SizedBox(height: 32),

          // Content
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    _isIndonesian
                        ? 'Akses hanya untuk Dosen dan Mahasiswa Telkom University.'
                        : 'Access restricted only for Lecturer and Student of Telkom University',
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    _isIndonesian
                        ? 'Login menggunakan Akun Microsoft Office 365 dengan mengikuti petunjuk berikut :'
                        : 'Login only using your Microsoft Office 365 Account by following these format :',
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    _isIndonesian
                        ? 'Username (Akun iGracias) ditambahkan "@365.telkomuniversity.ac.id"\nPassword (Akun iGracias) pada kolom Password.'
                        : 'Username (iGracias Account) followed with "@365.telkomuniversity.ac.id"\nPassword (SSO / iGracias Account) on Password Field.',
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    _isIndonesian
                        ? 'Kegagalan yang terjadi pada Autentikasi disebabkan oleh Anda belum mengubah Password Anda menjadi "Strong Password". Pastikan Anda telah melakukan perubahan Password di iGracias.'
                        : 'Failure upon Authentication could be possibly you have not yet change your password into "Strong Password". Make sure to change your Password only in iGracias.',
                  ),
                  const SizedBox(height: 24),
                   _buildSection(
                    _isIndonesian
                        ? 'Informasi lebih lanjut dapat menghubungi Layanan CeLOE Helpdesk di :'
                        : 'For further Information, please contact CeLOE Service Helpdesk :',
                  ),
                   const SizedBox(height: 12),
                   Text(
                    'Mail : hypoceloe@telkomuniversity.ac.id', // Updated generic mail as per typical implementation or specific if needed
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                   ),
                   Text(
                    'whatsapp : +62 821-1666-3563',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                   ),
                   const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String code, bool isId) {
    final isSelected = _isIndonesian == isId;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isIndonesian = isId;
        });
      },
      child: Column(
        children: [
          // Flag placeholder (using text/icon for simplicity as no assets provided)
          Container(
            width: 40,
            height: 26,
            decoration: BoxDecoration(
              color: isId ? Colors.red : const Color(0xFF00247D), // Simple flag rep
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: isId 
              ? Align(alignment: Alignment.topCenter, child: Container(height: 13, color: Colors.red)) // ID (Red/White - using white bg)
              : Center(child: Text('🇬🇧', style: TextStyle(fontSize: 16))), // EN Emoji
          ),
          const SizedBox(height: 8),
          Text(
            code,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              width: 20,
              height: 3,
              color: Colors.black87,
            ),
        ],
      ),
    );
  }
  
  // Custom Flag Widget to match style better without assets
  Widget _buildFlag(bool isId) {
     if (isId) {
       return Container(
         width: 30, height: 20,
         decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
         child: Column(
           children: [
             Expanded(child: Container(color: Colors.red)),
             Expanded(child: Container(color: Colors.white)),
           ],
         ),
       );
     } else {
        return Container(
         width: 30, height: 20,
         decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), color: Colors.blue[900]),
         child: Center(
           child: Stack(
             children: [
               const Icon(Icons.add, color: Colors.white, size: 20),
               Transform.rotate(angle: 0.785, child: const Icon(Icons.add, color: Colors.white, size: 20)),
             ],
           )
         ),
       );
     }
  }

  Widget _buildSection(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black87,
        height: 1.5,
      ),
      textAlign: TextAlign.left,
    );
  }
}
