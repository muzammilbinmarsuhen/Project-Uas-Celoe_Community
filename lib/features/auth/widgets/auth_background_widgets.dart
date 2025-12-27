import 'package:flutter/material.dart';

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
