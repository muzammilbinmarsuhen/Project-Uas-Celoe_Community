import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
       duration: const Duration(milliseconds: 2500), vsync: this,
    );

    // 1. Logo Entrance: Smooth Pop with Fade
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack))
    );
    
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.0, 0.4, curve: Curves.easeIn))
    );

    // 2. Text Content: Delays + Slide Up
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.5, 1.0, curve: Curves.easeIn))
    );
    
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
       CurvedAnimation(parent: _mainController, curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic))
    );

    _mainController.forward();
    _checkLoginAndNavigate();
  }

  Future<void> _checkLoginAndNavigate() async {
    await Future.delayed(const Duration(seconds: 4)); 
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
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
          children: [
             // Gradient Background
             Container(
                decoration: const BoxDecoration(
                   gradient: LinearGradient(
                      colors: [Color(0xFFB74B4B), Color(0xFF6A1B1B)], 
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                   )
                ),
             ),
             
             // Main Content
             Center(
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      // Logo Box with Glow and Animation
                      FadeTransition(
                        opacity: _logoFadeAnimation,
                        child: ScaleTransition(
                           scale: _scaleAnimation,
                           child: Container(
                              height: 180, width: 180,
                              padding: const EdgeInsets.all(35), // Increased padding for better proportion
                              decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.white,
                                 boxShadow: [
                                    BoxShadow(
                                       color: Colors.black.withValues(alpha: 0.1), // Softer shadow
                                       blurRadius: 30,
                                       spreadRadius: 2,
                                       offset: const Offset(0, 8)
                                    ),
                                    BoxShadow(
                                       color: Colors.white.withValues(alpha: 0.2), // Outer glow
                                       blurRadius: 20,
                                       spreadRadius: 5
                                    )
                                 ]
                              ),
                              child: Image.asset(
                                 'assets/images/Logo Celoe.png',
                                 fit: BoxFit.contain,
                                 errorBuilder: (ctx, _, __) => const Icon(Icons.school, size: 80, color: Color(0xFFA82E2E)),
                              ),
                           ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      
                      // Text Content
                      FadeTransition(
                         opacity: _textFadeAnimation,
                         child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                               children: [
                                  Text(
                                     'CeLOE Community',
                                     style: GoogleFonts.poppins(
                                        fontSize: 28, 
                                        fontWeight: FontWeight.bold, 
                                        color: Colors.white,
                                        letterSpacing: 1.2,
                                        shadows: [
                                           Shadow(
                                              color: Colors.black.withValues(alpha: 0.2),
                                              blurRadius: 6,
                                              offset: const Offset(0, 3)
                                           )
                                        ]
                                     ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                     decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.white.withValues(alpha: 0.15))
                                     ),
                                     child: Text(
                                        'Learning Management System',
                                        style: GoogleFonts.poppins(
                                           fontSize: 12, 
                                           color: Colors.white.withValues(alpha: 0.9),
                                           letterSpacing: 0.5,
                                           fontWeight: FontWeight.w500
                                        ),
                                     ),
                                  ),
                               ],
                            ),
                         ),
                      )
                   ],
                ),
             ),
             
             // Bottom Loading Indicator
             Positioned(
                bottom: 60, left: 0, right: 0,
                child: Center(
                   child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: const SizedBox(
                         width: 24, height: 24,
                         child: CircularProgressIndicator(
                           valueColor: AlwaysStoppedAnimation<Color>(Colors.white70), 
                           strokeWidth: 2.5
                         ),
                      ),
                   ),
                ),
             )
          ],
       ),
    );
  }
}