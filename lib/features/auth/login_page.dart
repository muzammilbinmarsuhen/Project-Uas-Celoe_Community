import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes.dart';
import 'login_help_sheet.dart';

class EllipticalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.15),
      width: size.width * 1.8,
      height: size.height * 1.7,
    ));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.2, size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.6, size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class FloatingParticlesPainter extends CustomPainter {
  final double animationValue;

  FloatingParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.1);

    for (int i = 0; i < 20; i++) {
      final x = (size.width / 20) * i + (animationValue * 10 * (i % 2 == 0 ? 1 : -1));
      final y = (size.height / 20) * (i % 20) + (animationValue * 5);
      canvas.drawCircle(Offset(x % size.width, y % size.height), 2, paint);
    }
  }

  @override
  bool shouldRepaint(FloatingParticlesPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}

class LiquidFillButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color fillColor;
  final Duration duration;

  const LiquidFillButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.fillColor = const Color(0xFFA82E2E),
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  State<LiquidFillButton> createState() => _LiquidFillButtonState();
}

class _LiquidFillButtonState extends State<LiquidFillButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePress() {
    _controller.forward(from: 0.0);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePress,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                colors: [
                  widget.fillColor.withValues(alpha: 0.8),
                  widget.fillColor,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.fillColor.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Liquid fill effect
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * _animation.value,
                        height: double.infinity,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
                // Wave overlay for liquid effect
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomPaint(
                      painter: LiquidWavePainter(_animation.value),
                    ),
                  ),
                ),
                widget.child,
              ],
            ),
          );
        },
      ),
    );
  }
}

class LiquidWavePainter extends CustomPainter {
  final double progress;

  LiquidWavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = 10.0;
    final waveLength = size.width / 4;

    path.moveTo(0, size.height);
    for (double x = 0; x <= size.width * progress; x += waveLength / 4) {
      final y = size.height - waveHeight * (1 - progress) +
          waveHeight * sin(x / (size.width * progress)) * progress;
      path.lineTo(x, y);
    }
    path.lineTo(size.width * progress, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LiquidWavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  
  // State
  bool _obscurePassword = true;
  bool _isLogin = true; 
  bool _isSplash = true; // NEW: Starts in Splash mode
  


  // Animations
  late AnimationController _mainController; // Controls background particles
  late Animation<double> _particleAnimation;

  late AnimationController _formController; // Controls Form appearance
  late Animation<double> _formFadeAnimation;
  late Animation<double> _formSlideAnimation;

  late AnimationController _logoPulseController; // Controls Logo Pulse on Splash
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check if already logged in
    
    // 1. Background Particles (Continuous)
    _mainController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.linear),
    );

    // 2. Logo Pulse (While in Splash)
    _logoPulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _logoScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _logoPulseController, curve: Curves.easeInOut),
    );

    // 3. Form Intro (Triggered on Click)
    _formController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _formFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _formController, curve: const Interval(0.4, 1.0, curve: Curves.easeOut)),
    );
    _formSlideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _formController, curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic)),
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _formController.dispose();
    _logoPulseController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSplashTap() {
    setState(() {
      _isSplash = false;
    });
    _logoPulseController.stop(); // Stop pulsing
    _formController.forward(); // Start showing form
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    
    if (isLoggedIn && mounted) {
      final username = prefs.getString('username') ?? 'Mahasiswa';
      // Auto-navigate to Home
      Navigator.pushReplacementNamed(
        context, 
        AppRoutes.home,
        arguments: {'username': username, 'email': prefs.getString('email') ?? 'student@celoe.com'},
      );
    }
  }

  Future<void> _handleAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Email dan Password wajib diisi', isError: true);
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    if (!_isLogin) {
      // REGISTER
      if (username.isEmpty) {
        _showMessage('Username wajib diisi', isError: true);
        return;
      }
      
      // Simple Overwrite Registration (Single User for Demo)
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setString('username', username);
      await prefs.setBool('isLoggedIn', true); // Auto Login

      _showMessage('Registrasi berhasil! Selamat datang $username');
      
      if (mounted) {
         Navigator.pushReplacementNamed(
            context, 
            AppRoutes.home,
            arguments: {'username': username, 'email': email},
         );
      }

    } else {
      // LOGIN
      final savedEmail = prefs.getString('email');
      final savedPassword = prefs.getString('password');
      final savedUsername = prefs.getString('username');

      if (savedEmail != email) {
        _showMessage('Email tidak terdaftar/salah.', isError: true);
        return;
      }
      
      if (savedPassword != password) {
        _showMessage('Password salah!', isError: true);
        return;
      }

      await prefs.setBool('isLoggedIn', true);
      _showMessage('Login Berhasil! Selamat datang $savedUsername');
      
      if (mounted) {
        Navigator.pushReplacementNamed(
          context, 
          AppRoutes.home,
          arguments: {'username': savedUsername, 'email': savedEmail},
        );
      }
    }
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
      // Re-trigger form animation slightly for effect
      _formController.value = 0.4;
      _formController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Static/Animated Background
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
          
          // 2. Main Layout (Splash -> Form)
          Stack(
            children: [
              // HEADER IMAGE (Always visible, but changes size/clipper)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutCubic,
                top: 0,
                left: 0,
                right: 0,
                height: _isSplash ? size.height : size.height * 0.35,
                child: ClipPath(
                  clipper: _isSplash ? null : EllipticalClipper(),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/uim.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Container(
                         color: Colors.black.withValues(alpha: _isSplash ? 0.6 : 0.3),
                      ),
                    ],
                  ),
                ),
              ),

              // SPLASH CONTENT (Centered Logo)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutCubic,
                top: _isSplash ? (size.height / 2) - 80 : 60, // Move to header position
                left: 0, 
                right: 0,
                child: GestureDetector(
                  onTap: _isSplash ? _onSplashTap : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaleTransition(
                        scale: _isSplash ? _logoScaleAnimation : const AlwaysStoppedAnimation(1.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          width: _isSplash ? 160 : 80,
                          height: _isSplash ? 160 : 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFA82E2E), // Primary Red
                            border: Border.all(color: Colors.white, width: _isSplash ? 6 : 3),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFA82E2E).withValues(alpha: 0.5),
                                blurRadius: _isSplash ? 50 : 20,
                                spreadRadius: _isSplash ? 10 : 2,
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.school_rounded, // Changed Icon for "University/Education" feel
                            size: _isSplash ? 80 : 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (_isSplash) ...[
                        const SizedBox(height: 30),
                        Text(
                          "CeLOE Community",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Tap to Connect",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),

              // FORM CONTENT (Slides In)
              if (!_isSplash)
                Positioned.fill(
                  top: size.height * 0.35, // Below the header
                  child: AnimatedBuilder(
                    animation: _formController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _formFadeAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, _formSlideAnimation.value),
                          child: child,
                        ),
                      );
                    },
                    // The Actual Scrollable Form
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           Text(
                            _isLogin ? 'Selamat Datang' : 'Bergabunglah',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFA82E2E),
                            ),
                          ),
                          Text(
                            _isLogin ? 'Login untuk melanjutkan belajar' : 'Buat akun komunitas baru',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 40),

                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                if (!_isLogin) ...[
                                  TextFormField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.person, color: Color(0xFFA82E2E)),
                                      labelText: 'Username',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email, color: Color(0xFFA82E2E)),
                                    labelText: 'Email',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock, color: Color(0xFFA82E2E)),
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                    ),
                                    labelText: 'Password',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                
                                // Buttons
                                SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: LiquidFillButton(
                                    onPressed: _handleAuth,
                                    child: Text(
                                      _isLogin ? 'MASUK' : 'DAFTAR',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          if (_isLogin)
                            TextButton(
                               onPressed: () {
                                 // Help sheet
                                 showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) => DraggableScrollableSheet(
                                      initialChildSize: 0.7,
                                      minChildSize: 0.5,
                                      maxChildSize: 0.95,
                                      builder: (_, c) => LoginHelpSheet(scrollController: c),
                                    ),
                                  );
                               },
                               child: Text("Butuh Bantuan?", style: GoogleFonts.poppins(color: Colors.grey)),
                            ),

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_isLogin ? "Belum punya akun? " : "Sudah punya akun? "),
                              GestureDetector(
                                onTap: _toggleMode,
                                child: Text(
                                  _isLogin ? "Daftar" : "Login",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFA82E2E),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50), // Bottom padding
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Bottom Curve Decor (Only visible in Splash or transitioning)
          if (_isSplash)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 100,
                  color: const Color(0xFFA82E2E).withValues(alpha: 0.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
