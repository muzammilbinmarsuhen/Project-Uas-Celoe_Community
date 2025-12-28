import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool _isIndonesian = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Drag Handle
            Center(
              child: Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            
            // Close Button (Small UX addition not in screen but necessary for modal flow if swipe fails)
            Align(
               alignment: Alignment.centerLeft,
               child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
               ),
            ),

            const SizedBox(height: 10),

            // Language Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLangOption('ID', true, '🇮🇩'), // Using Emoji for Flag
                const SizedBox(width: 60),
                _buildLangOption('EN', false, '🇬🇧'),
              ],
            ),
            const SizedBox(height: 30),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                        _getContent(0),
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                     ),
                     const SizedBox(height: 24),
                     Text(
                        _getContent(1),
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                     ),
                     const SizedBox(height: 24),
                     Text(
                        _getContent(2),
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                     ),
                     const SizedBox(height: 24),
                     Text(
                        _getContent(3),
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                     ),
                     const SizedBox(height: 24),
                     Text(
                        _getContent(4),
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                     ),
                     const SizedBox(height: 24),
                     Text(
                        _getContent(5),
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                     ),
                     const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangOption(String text, bool isId, String flagEmoji) {
    final isActive = _isIndonesian == isId;
    return GestureDetector(
      onTap: () => setState(() => _isIndonesian = isId),
      child: Column(
        children: [
          // Flag
          Text(
            flagEmoji,
            style: const TextStyle(fontSize: 40), 
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          // Indicator
          Container(
            height: 3,
            width: 20,
            decoration: BoxDecoration(
               color: isActive ? Colors.grey[700] : Colors.transparent,
               borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  String _getContent(int section) {
     if (_isIndonesian) {
        switch (section) {
           case 0: return 'Akses hanya untuk Dosen dan Mahasiswa Telkom University.';
           case 1: return 'Login menggunakan Akun Microsoft Office 365\ndengan mengikuti petunjuk berikut :';
           case 2: return 'Username (Akun iGracias) ditambahkan "@365.telkomuniversity.ac.id"\nPassword (Akun iGracias) pada kolom Password.';
           case 3: return 'Kegagalan yang terjadi pada Autentikasi disebabkan oleh\nAnda belum mengubah Password Anda menjadi "Strong Password".\nPastikan Anda telah melakukan perubahan Password di iGracias.';
           case 4: return 'Informasi lebih lanjut dapat menghubungi Layanan CeLOE Helpdesk di :';
           case 5: return 'Mail : infoceloe@telkomuniversity.ac.id\nwhatsapp : +62 821-1666-3563';
           default: return '';
        }
     } else {
        switch (section) {
           case 0: return 'Access restricted only for Lecturer and Student of Telkom University';
           case 1: return 'Login only using your Microsoft Office 365 Account\nby following these format :';
           case 2: return 'Username (iGracias Account) followed with "@365.telkomuniversity.ac.id"\nPassword (SSO / iGracias Account) on Password Field.';
           case 3: return 'Failure upon Authentication could be possibly you\nhave not yet change your password into "Strong Password".\nMake sure to change your Password only in iGracias.';
           case 4: return 'For further Information, please contact CeLOE Service Helpdesk :';
           case 5: return 'mail : infoceloe@telkomuniversity.ac.id\nwhatsapp : +62 821-1666-3563';
           default: return '';
        }
     }
  }
}
