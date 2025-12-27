import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/custom_button.dart';
import '../auth/widgets/auth_background_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('isLoggedIn', true);

      if (mounted) {
         setState(() => _isLoading = false);
         Navigator.pushReplacementNamed(
            context, 
            AppRoutes.home,
            arguments: {'username': _usernameController.text, 'email': _emailController.text},
         );
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
                               isPassword: true,
                               validator: (val) => val!.length < 6 ? 'Min. 6 karakter' : null,
                               suffixIcon: const Icon(Icons.lock_outline),
                             ),
                             const SizedBox(height: 16),
                             CustomTextField(
                               label: 'Konfirmasi Password',
                               hint: 'Ulangi password',
                               controller: _confirmPasswordController,
                               isPassword: true,
                               validator: (val) => val != _passwordController.text ? 'Password tidak sama' : null,
                               suffixIcon: const Icon(Icons.lock_outline),
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
