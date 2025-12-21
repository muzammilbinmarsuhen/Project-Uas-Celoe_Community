import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/routes.dart';

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
    final paint = Paint()..color = Colors.white.withOpacity(0.1);

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController(); // New Username Controller
  
  // State
  bool _obscurePassword = true;
  bool _isLogin = true; // Toggle state
  
  // Logic (Mock Database)
  final Map<String, Map<String, String>> _users = {}; // email -> {username, password}

  List<Offset> _points = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  void _handleAuth() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Email dan Password wajib diisi', isError: true);
      return;
    }

    if (!_isLogin) {
      // REGISTER LOGIC
      if (username.isEmpty) {
        _showMessage('Username wajib diisi', isError: true);
        return;
      }
      if (_users.containsKey(email)) {
        _showMessage('Email sudah terdaftar. Silakan login.', isError: true);
        setState(() => _isLogin = true); // Switch to login
        return;
      }
      
      // Save user
      _users[email] = {
        'username': username,
        'password': password,
      };
      
      _showMessage('Registrasi berhasil! Silakan login.');
      setState(() {
        _isLogin = true;
        _passwordController.clear(); // Clear password for security
      });
    } else {
      // LOGIN LOGIC
      if (!_users.containsKey(email)) {
        _showMessage('Akun tidak ditemukan. Silakan daftar terlebih dahulu.', isError: true);
        return;
      }
      
      if (_users[email]!['password'] != password) {
        _showMessage('Password salah!', isError: true);
        return;
      }

      // Success
      _showMessage('Login Berhasil! Selamat datang ${_users[email]!['username']}');
      Navigator.pushReplacementNamed(
        context, 
        AppRoutes.home,
        arguments: _users[email]!['username'],
      );
    }
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
      _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
        ),
      );
      // Restart animation for effect
      _animationController.reset();
      _animationController.forward();
      // Keep repeating for particles but forward for fade reset
      _animationController.repeat(reverse: true); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Particles Background
          AnimatedBuilder(
            animation: _particleAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: FloatingParticlesPainter(_particleAnimation.value),
                size: Size.infinite,
              );
            },
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Header with Image and Floating Logo
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: EllipticalClipper(),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset(
                            'assets/images/uim.jpg',
                            key: ValueKey<bool>(_isLogin), // Potentially change image based on mode if needed
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                              const Color(0xFFA82E2E).withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                      // Glassmorphism effect
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _fadeAnimation.value,
                                child: Transform.translate(
                                  offset: Offset(0, _slideAnimation.value),
                                  child: Container(
                                    width: 96,
                                    height: 96,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFA82E2E),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                        BoxShadow(
                                          color: const Color(0xFFA82E2E).withOpacity(0.3),
                                          blurRadius: 30,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      _isLogin ? Icons.lock_open : Icons.person_add,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Form with Glassmorphism
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.1),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isLogin ? 'Login' : 'Daftar Akun',
                                      style: GoogleFonts.poppins(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        shadows: [
                                          Shadow(
                                            color: Colors.white.withOpacity(0.5),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    
                                    // Username Field (Only visible in Register mode)
                                    if (!_isLogin)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 32.0),
                                        child: TextFormField(
                                          controller: _usernameController,
                                          cursorColor: const Color(0xFFA82E2E),
                                          style: GoogleFonts.poppins(color: Colors.black),
                                          decoration: InputDecoration(
                                            labelText: 'Username',
                                            labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                                            floatingLabelStyle: GoogleFonts.poppins(color: const Color(0xFFA82E2E)),
                                            border: const UnderlineInputBorder(),
                                            enabledBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFFA82E2E)),
                                            ),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFFA82E2E), width: 2),
                                            ),
                                            prefixIcon: const Icon(Icons.person_outline, color: Color(0xFFA82E2E)),
                                          ),
                                        ),
                                      ),

                                    // Email Field
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: const Color(0xFFA82E2E),
                                      style: GoogleFonts.poppins(color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Email 365',
                                        labelStyle: GoogleFonts.poppins(
                                          color: Colors.grey[700],
                                        ),
                                        floatingLabelStyle: GoogleFonts.poppins(
                                          color: const Color(0xFFA82E2E),
                                        ),
                                        border: const UnderlineInputBorder(),
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA82E2E)),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA82E2E), width: 2),
                                        ),
                                        prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFA82E2E)),
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    // Password Field
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      cursorColor: const Color(0xFFA82E2E),
                                      style: GoogleFonts.poppins(color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: GoogleFonts.poppins(
                                          color: Colors.grey[700],
                                        ),
                                        floatingLabelStyle: GoogleFonts.poppins(
                                          color: const Color(0xFFA82E2E),
                                        ),
                                        border: const UnderlineInputBorder(),
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA82E2E)),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA82E2E), width: 2),
                                        ),
                                        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFA82E2E)),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                            color: Colors.grey[600],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword = !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Forgot Password / Help
                                    if (_isLogin)
                                      Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) => DraggableScrollableSheet(
                                                initialChildSize: 0.7,
                                                minChildSize: 0.5,
                                                maxChildSize: 0.95,
                                                builder: (_, controller) => const LoginHelpSheet(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Bantuan ?',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFFA82E2E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 32),
                                    // Action Button
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _handleAuth,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFA82E2E),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          elevation: 12,
                                          shadowColor: const Color(0xFFA82E2E).withOpacity(0.4),
                                        ),
                                        child: Text(
                                          _isLogin ? 'Log In' : 'Daftar Sekarang',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Toggle Mode Button
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: _toggleMode,
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(color: Color(0xFFA82E2E)),
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Text(
                                          _isLogin ? 'Buat Akun Baru' : 'Sudah punya akun? Login',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFFA82E2E),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                // Enhanced Connect the Dots Animation (kept for consistent aesthetic)
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        height: 150, // Reduced height
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Center(
                           child: Text(
                              'CeLOE Community', // Simple Branding
                              style: GoogleFonts.poppins(
                                color: Colors.grey[400],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100), // Space for bottom wave
              ],
            ),
          ),
          // Enhanced Bottom Wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFA82E2E),
                      Color(0xFF7F1D1D),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotPainter extends CustomPainter {
  final List<Offset> points;

  _DotPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFA82E2E)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (points.length > 1) {
      final path = Path();
      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);
    }

    // Draw dots
    final dotPaint = Paint()
      ..color = const Color(0xFFA82E2E)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 10; j++) {
        final x = (size.width / 21) * (i + 1);
        final y = (size.height / 11) * (j + 1);
        canvas.drawCircle(Offset(x, y), 3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotPainter oldDelegate) => true;
}