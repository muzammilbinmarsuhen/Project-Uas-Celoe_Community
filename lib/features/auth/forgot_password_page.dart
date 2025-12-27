import 'package:flutter/material.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/custom_button.dart';
import '../auth/widgets/auth_background_widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleReset() async {
    if (_emailController.text.isNotEmpty) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Link reset password telah dikirim ke email anda')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
             top: 0, left: 0, right: 0,
             height: 250,
             child: ClipPath(
                clipper: EllipticalClipper(),
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
              child: Column(
                children: [
                   const SizedBox(height: 60),
                   const Icon(Icons.lock_reset, size: 80, color: Colors.white),
                   const SizedBox(height: 24),
                   const Text(
                      'Lupa Password?',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                   ),
                   const SizedBox(height: 8),
                   const Text(
                      'Masukkan email untuk reset password',
                      style: TextStyle(color: Colors.white70),
                   ),
                   const SizedBox(height: 80),
                   
                   Container(
                     padding: const EdgeInsets.all(24),
                     decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
                     ),
                     child: Column(
                       children: [
                         CustomTextField(
                           label: 'Email',
                           hint: 'Masukkan email terdaftar',
                           controller: _emailController,
                           keyboardType: TextInputType.emailAddress,
                           suffixIcon: const Icon(Icons.email_outlined),
                         ),
                         const SizedBox(height: 24),
                         SizedBox(
                           width: double.infinity,
                           child: CustomButton(
                             text: 'KIRIM LINK RESET',
                             isLoading: _isLoading,
                             onPressed: _handleReset,
                           ),
                         ),
                       ],
                     ),
                   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
