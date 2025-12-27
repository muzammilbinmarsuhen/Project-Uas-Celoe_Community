import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models.dart';
import '../profile_controller.dart';

class EditProfileTab extends ConsumerStatefulWidget {
  final UserModel user;

  const EditProfileTab({super.key, required this.user});

  @override
  ConsumerState<EditProfileTab> createState() => _EditProfileTabState();
}

class _EditProfileTabState extends ConsumerState<EditProfileTab> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController; // Read only usually for email? Plan said "Email" form field
  late TextEditingController _countryController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _firstNameController = TextEditingController(text: widget.user.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.user.lastName ?? '');
    _emailController = TextEditingController(text: widget.user.email);
    _countryController = TextEditingController(text: widget.user.country ?? '');
    _descriptionController = TextEditingController(text: widget.user.description ?? '');
  }

  @override
  void didUpdateWidget(EditProfileTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user != oldWidget.user) {
      // Logic to update controllers if user changes externally could go here
      // But for edit form, we usually keep user input until they save or reset.
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final updatedUser = UserModel(
      id: widget.user.id,
      username: widget.user.username, // Keep original username or update? 
      email: _emailController.text,
      avatarUrl: widget.user.avatarUrl,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      country: _countryController.text,
      description: _descriptionController.text,
      faculty: widget.user.faculty,
      studyProgram: widget.user.studyProgram,
      firstAccess: widget.user.firstAccess,
      lastAccess: widget.user.lastAccess,
    );

    ref.read(profileControllerProvider.notifier).updateUser(updatedUser);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildTextField('First Name', _firstNameController)),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField('Last Name', _lastNameController)),
            ],
          ),
          _buildTextField('Email', _emailController),
          _buildTextField('Country', _countryController),
          _buildTextField('Description', _descriptionController, maxLines: 4),

          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
               width: 120,
               height: 45,
               child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA82E2E),
                  elevation: 2,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
               ),
            ),
          ),
           const SizedBox(height: 40),
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
