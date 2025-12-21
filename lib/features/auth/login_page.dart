import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5, size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() {
    // UI only, no logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double imageHeight = constraints.maxHeight * 0.4;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header with Image and Floating Logo
                SizedBox(
                  height: imageHeight + 40, // Extra for logo overlap
                  child: Stack(
                    children: [
                      SizedBox(
                        height: imageHeight,
                        child: ClipPath(
                          clipper: DiagonalClipper(),
                          child: Image.asset(
                            'assets/images/UIM.JPG',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        top: imageHeight - 40,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xFFB74A4A),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('assets/images/Logo Celoe.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                // Login Form
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Email 365',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color(0xFFB74A4A),
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            border: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB74A4A)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB74A4A)),
                            ),
                          ),
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          cursorColor: const Color(0xFFB74A4A),
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            border: const UnderlineInputBorder(),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB74A4A)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB74A4A)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Bantuan ?',
                              style: GoogleFonts.poppins(color: const Color(0xFFB74A4A)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB74A4A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              shadowColor: Colors.black26,
                              elevation: 5,
                            ),
                            child: Text(
                              'Log In',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Navigate to create account or show message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fitur buat akun belum tersedia')),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFB74A4A)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Buat Akun',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFB74A4A),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Footer Wave
                SizedBox(
                  height: 100,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: const Color(0xFFB74A4A),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}