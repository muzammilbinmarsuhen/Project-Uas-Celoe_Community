import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/routes/routes.dart';
import '../auth/widgets/auth_background_widgets.dart'; // Import Shared Widgets

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.forward(); 
    // We don't repeat here to keep transition simple.

    _checkLoginAndNavigate();
  }

  Future<void> _checkLoginAndNavigate() async {
    // Artificial Delay for Splash Effect
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
       final username = prefs.getString('username') ?? 'Mahasiswa';
       final email = prefs.getString('email') ?? 'student@celoe.com';
       Navigator.pushReplacementNamed(
          context, 
          AppRoutes.home,
          arguments: {'username': username, 'email': email},
       );
    } else {
       Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB74A4A),
                  Color(0xFFA82E2E), 
                  Color(0xFF7F1D1D), 
                ],
              ),
            ),
          ),
          
          // Animated Particles
          AnimatedBuilder(
            animation: _particleAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: FloatingParticlesPainter(_particleAnimation.value),
                size: Size.infinite,
              );
            },
          ),

          // Glassmorphism Overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.white.withValues(alpha: 0.02),
            ),
          ),

          // Main Content with LayoutBuilder
          LayoutBuilder(
            builder: (context, constraints) {
              // Calculate responsive sizes based on constraints
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              final logoSize = width * 0.4;
              final textSize = width * 0.06;
              final isSmallScreen = height < 600;

              return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                              child: Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Container(
                                  width: logoSize,
                                  height: logoSize,
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: 200,
                                    minHeight: 100, 
                                    maxHeight: 200
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      )
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                    'assets/images/Logo Celoe.png',
                                    errorBuilder: (ctx, _, __) => const Icon(Icons.school, size: 50, color: Color(0xFFA82E2E)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: isSmallScreen ? 16 : 32),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                              child: Column(
                                 children: [
                                    Text(
                                      'CeLOE Community',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: textSize.clamp(18, 32), // Adaptive with limits
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withValues(alpha: 0.3),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Learning Management System',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: (textSize * 0.5).clamp(12, 16),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: isSmallScreen ? 16 : 40),
                                    // Simple Loading Indicator
                                    const SizedBox(
                                      width: 20, 
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white54, 
                                        strokeWidth: 2,
                                      ),
                                    ),
                                 ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}