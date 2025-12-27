import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../routes/app_routes.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/custom_button.dart';
import '../auth/widgets/auth_background_widgets.dart';
import 'data/auth_repository.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Split username (or in future add dedicated fields) for first/last name
      // Logic: First word is First Name, rest is Last Name
      final fullName = _usernameController.text.trim();
      final parts = fullName.split(' ');
      final firstName = parts.first;
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      
      final success = await ref.read(authRepositoryProvider).register(
          _usernameController.text, // Use full name as username also for now
          _emailController.text, 
          _passwordController.text,
          firstName,
          lastName
      );

      if (mounted) {
         setState(() => _isLoading = false);
         if (success) {
            // Navigate to login or home? Let's go to Login to force re-auth or auto-login
            Navigator.pushReplacementNamed(context, AppRoutes.login);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
            );
         } else {
             ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registrasi gagal. Coba lagi.')),
            );
         }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Header
          Positioned(
             top: 0, left: 0, right: 0,
             height: MediaQuery.of(context).size.height * 0.3,
             child: ClipPath(
                clipper: EllipticalClipper(), // Shared Widget
                child: Container(
                   decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFB74A4A), Color(0xFFA82E2E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                   ),
                ),
             ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Buat Akun Baru',
                      style: TextStyle(
                         fontSize: 28,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Bergabunglah dengan komunitas kami',
                      style: TextStyle(
                         fontSize: 14,
                         color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 80), // Spacer for header

                    // Form Card
                    Container(
                       padding: const EdgeInsets.all(24),
                       decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                             BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                offset: Offset(0, 5),
                             )
                          ],
                       ),
                       child: Column(
                          children: [
                             CustomTextField(
                               label: 'Username',
                               hint: 'Masukkan username',
                               controller: _usernameController,
                               validator: (val) => val!.isEmpty ? 'Username wajib diisi' : null,
                               suffixIcon: const Icon(Icons.person_outline),
                             ),
                             const SizedBox(height: 16),
                             CustomTextField(
                               label: 'Email',
                               hint: 'Masukkan email',
                               controller: _emailController,
                               keyboardType: TextInputType.emailAddress,
                               validator: (val) => !val!.contains('@') ? 'Email tidak valid' : null,
                               suffixIcon: const Icon(Icons.email_outlined),
                             ),
                             const SizedBox(height: 16),
                             CustomTextField(
                               label: 'Password',
                               hint: 'Buat password',
                               controller: _passwordController,
                               isPassword: _obscurePassword,
                               validator: (val) => val!.length < 6 ? 'Min. 6 karakter' : null,
                               suffixIcon: IconButton(
                                 icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                                 onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                               ),
                             ),
                             const SizedBox(height: 16),
                             CustomTextField(
                               label: 'Konfirmasi Password',
                               hint: 'Ulangi password',
                               controller: _confirmPasswordController,
                               isPassword: _obscureConfirmPassword,
                               validator: (val) => val != _passwordController.text ? 'Password tidak sama' : null,
                               suffixIcon: IconButton(
                                 icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                                 onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                               ),
                             ),
                             const SizedBox(height: 32),
                             
                             SizedBox(
                               width: double.infinity,
                               child: CustomButton(
                                  text: 'DAFTAR',
                                  isLoading: _isLoading,
                                  onPressed: _handleRegister,
                               ),
                             ),
                          ],
                       ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sudah punya akun? "),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                             "Login",
                             style: TextStyle(
                               color: Color(0xFFA82E2E),
                               fontWeight: FontWeight.bold,
                             ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
