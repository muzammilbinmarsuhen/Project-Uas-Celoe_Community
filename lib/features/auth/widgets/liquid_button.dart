import 'dart:math';
import 'package:flutter/material.dart';

class LiquidFillButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color fillColor;
  final Duration duration;

  const LiquidFillButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.fillColor = const Color(0xFFA82E2E), // Default Maroon
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<LiquidFillButton> createState() => _LiquidFillButtonState();
}

class _LiquidFillButtonState extends State<LiquidFillButton> with SingleTickerProviderStateMixin {
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
    // Delay actual action slightly to show fill effect
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) widget.onPressed();
    });
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.fillColor,
                  Color.lerp(widget.fillColor, Colors.black, 0.2)!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.fillColor.withValues(alpha: 0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. Progress Fill
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * _animation.value,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
                // 2. Wave Effect
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomPaint(
                      painter: LiquidWavePainter(
                        _animation.value, 
                        offset: _animation.value * 100, 
                        color: Colors.white.withValues(alpha: 0.3)
                      ),
                    ),
                  ),
                ),
                // 3. Second Wave
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomPaint(
                      painter: LiquidWavePainter(
                        _animation.value * 0.85, 
                        offset: _animation.value * 150 + 50, 
                        color: Colors.white.withValues(alpha: 0.15)
                      ),
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
  final double offset;
  final Color color;

  LiquidWavePainter(this.progress, {this.offset = 0, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0); 

    const step = 2.0; 
    final rightEdgeX = size.width * progress;
    
    for (double y = 0; y <= size.height; y += step) {
       final x = rightEdgeX + sin((y + offset) / 40) * 25 * (1.1 - progress); 
       path.lineTo(x, y);
    }

    path.lineTo(0, size.height); 
    path.close();

    // Wavy Right Edge Overlay
    final overlayPath = Path();
    overlayPath.moveTo(0, 0);
    for(double y = 0; y <= size.height; y+= 2) {
       final wave = sin((y + offset * 10) / 15) * 8; 
       overlayPath.lineTo((size.width * progress) + wave, y);
    }
    overlayPath.lineTo(size.width * progress, size.height);
    overlayPath.lineTo(0, size.height);
    overlayPath.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LiquidWavePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.offset != offset;
}
