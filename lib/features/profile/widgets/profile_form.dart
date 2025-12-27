import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileForm extends ConsumerStatefulWidget {
  final UserModel user;
  final Function(UserModel) onSave;

  const ProfileForm({super.key, required this.user, required this.onSave});

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _facultyController;
  late TextEditingController _studyProgramController;
  late TextEditingController _countryController;
  late TextEditingController _bioController;
  bool _isModified = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    _facultyController = TextEditingController(text: widget.user.faculty);
    _studyProgramController = TextEditingController(text: widget.user.studyProgram);
    _countryController = TextEditingController(text: widget.user.country);
    _bioController = TextEditingController(text: widget.user.description);
    
    _firstNameController.addListener(_checkModification);
    _lastNameController.addListener(_checkModification);
    _facultyController.addListener(_checkModification);
    _studyProgramController.addListener(_checkModification);
    _countryController.addListener(_checkModification);
    _bioController.addListener(_checkModification);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _facultyController.dispose();
    _studyProgramController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
               children: [
                  Expanded(child: _buildTextField(label: 'First Name', controller: _firstNameController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(label: 'Last Name', controller: _lastNameController)),
               ],
            ),
            const SizedBox(height: 16),
            _buildTextField(label: 'Email', controller: _emailController, enabled: false),
            const SizedBox(height: 16),
            _buildTextField(label: 'Fakultas', controller: _facultyController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Program Studi', controller: _studyProgramController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Country', controller: _countryController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Description', controller: _bioController, maxLines: 3),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: (_isModified && !_isSaving) ? _handleSave : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isModified ? const Color(0xFFA82E2E) : Colors.grey[400],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: _isModified ? 4 : 0,
                  ),
                  child: _isSaving 
                     ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                     : Text(
                    'Simpan Perubahan',
                    style: GoogleFonts.poppins(
                       fontSize: 16, 
                       fontWeight: FontWeight.w600,
                       color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkModification() {
    final isChanged = 
        _firstNameController.text != (widget.user.firstName ?? '') ||
        _lastNameController.text != (widget.user.lastName ?? '') ||
        _facultyController.text != (widget.user.faculty ?? '') ||
        _studyProgramController.text != (widget.user.studyProgram ?? '') ||
        _countryController.text != (widget.user.country ?? '') ||
        _bioController.text != (widget.user.description ?? '');
    
    if (isChanged != _isModified) {
      setState(() => _isModified = isChanged);
    }
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate()) {
       setState(() => _isSaving = true);
       
       // Simulate networking visual
       await Future.delayed(const Duration(milliseconds: 800));

       final updatedUser = UserModel(
          id: widget.user.id,
          username: '${_firstNameController.text} ${_lastNameController.text}'.trim(),
          email: widget.user.email,
          photoPath: widget.user.photoPath,
          avatarUrl: widget.user.avatarUrl,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          country: _countryController.text,
          description: _bioController.text,
          faculty: _facultyController.text,
          studyProgram: _studyProgramController.text,
          firstAccess: widget.user.firstAccess,
          lastAccess: widget.user.lastAccess,
       );
       
       widget.onSave(updatedUser);
       
       if (mounted) {
         setState(() {
            _isSaving = false;
            _isModified = false;
         });
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
                content: Text('Profil berhasil diperbaharui!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
             ),
         );
       }
    }
  }

  Widget _buildTextField({
      required String label, 
      required TextEditingController controller, 
      bool enabled = true,
      int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700])),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          style: GoogleFonts.poppins(fontSize: 15),
          decoration: InputDecoration(
             filled: true,
             fillColor: enabled ? Colors.white : Colors.grey[100],
             border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
             ),
             enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
             ),
             focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFA82E2E)),
             ),
             contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Field ini tidak boleh kosong' : null,
        ),
      ],
    );
  }
}
