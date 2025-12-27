
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import '../../core/widgets/custom_text_field.dart';
import 'auth_controller.dart';
import 'widgets/auth_background_widgets.dart';
import 'widgets/liquid_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  
  // Animation for background
  late AnimationController _bgController;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.linear)
    );
  }

  @override
  void dispose() {
    _bgController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan Password wajib diisi'), backgroundColor: Colors.red),
      );
      return;
    }

    // Call AuthController
    await ref.read(authControllerProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Listen to Auth State
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      next.when(
        data: (_) {
          // Success: Navigate to Home
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString().replaceAll('Exception: ', '')), backgroundColor: Colors.red),
          );
        },
        loading: () {},
      );
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Background Particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: FloatingParticlesPainter(_particleAnimation.value),
                );
              },
            ),
          ),
          
          // 2. Header
          Positioned(
             top: 0, left: 0, right: 0,
             height: size.height * 0.4, // 40% height for header
             child: ClipPath(
                clipper: EllipticalClipper(),
                child: Stack(
                   children: [
                      Image.asset(
                         'assets/images/uim.jpg',
                         fit: BoxFit.cover,
                         width: double.infinity,
                         height: double.infinity,
                         errorBuilder: (_,__,___) => Container(color: const Color(0xFFA82E2E)),
                      ),
                      Container(color: const Color(0xFFA82E2E).withValues(alpha: 0.7)), // Overlay
                      Center(
                         child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(Icons.school, color: Colors.white, size: 50),
                               ),
                               const SizedBox(height: 12),
                               Text(
                                  'CeLOE Community',
                                  style: GoogleFonts.poppins(
                                     fontSize: 24,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.white,
                                  ),
                               ),
                            ],
                         ),
                      ),
                   ],
                ),
             ),
          ),

          // 3. Login Form
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content
                children: [
                   SizedBox(height: size.height * 0.35), // Spacer to push form down
                   
                   Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(24),
                         boxShadow: [
                            BoxShadow(
                               color: Colors.black.withValues(alpha: 0.1),
                               blurRadius: 20,
                               offset: const Offset(0, 5),
                            )
                         ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                             'Selamat Datang',
                             textAlign: TextAlign.center,
                             style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFA82E2E),
                             ),
                          ),
                          const SizedBox(height: 24),
                          
                          CustomTextField(
                            label: 'Email',
                            hint: 'Masukkan email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            suffixIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Password',
                            hint: 'Masukkan password',
                            controller: _passwordController,
                            isPassword: _obscurePassword,
                            suffixIcon: IconButton(
                               icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                               onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                               onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                               child: Text('Lupa Password?', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          SizedBox(
                             height: 55,
                             width: double.infinity,
                             child: isLoading 
                               ? const Center(child: CircularProgressIndicator())
                               : LiquidFillButton(
                                onPressed: _handleLogin,
                                child: Text('MASUK', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                             ),
                          ),
                        ],
                      ),
                   ),

                   const SizedBox(height: 24),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Text('Belum punya akun? '),
                         GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/register'),
                            child: Text(
                               'Daftar Sekarang',
                               style: GoogleFonts.poppins(
                                  color: const Color(0xFFA82E2E),
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
        ],
      ),
    );
  }
}

