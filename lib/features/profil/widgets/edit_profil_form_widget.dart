import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilFormWidget extends StatefulWidget {
  const EditProfilFormWidget({super.key});

  @override
  State<EditProfilFormWidget> createState() => _EditProfilFormWidgetState();
}

class _EditProfilFormWidgetState extends State<EditProfilFormWidget> {
  final _firstNameController = TextEditingController(text: 'DANDY CANDRA');
  final _lastNameController = TextEditingController(text: 'PRATA');
  final _emailController = TextEditingController(text: 'dandycandrapratama&365telkomuniversity.ac.id');
  final _countryController = TextEditingController(text: 'Indonesia');
  final _descriptionController = TextEditingController(text: 'Mahasiswa S1 Desain Komunikasi Visual yang memiliki minat tinggi di bidang UI/UX Design');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Nama Pertama', _firstNameController),
          _buildTextField('Nama Terakhir', _lastNameController),
          _buildTextField('E-mail Address', _emailController),
          _buildTextField('Negara', _countryController),
          _buildTextField('Deskripsi', _descriptionController, maxLines: 4),
          
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
               width: 120,
               height: 45,
               child: ElevatedButton(
                onPressed: () {
                   // No logic as requested
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Perubahan Disimpan (UI Only)')),
                   );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300], // Disabled look
                  elevation: 0,
                  foregroundColor: Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
               ),
            ),
          ),
          const SizedBox(height: 40), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFA82E2E)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
