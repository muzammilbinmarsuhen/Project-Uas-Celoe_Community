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

class _LiquidFillButtonState extends State<LiquidFillButton> with TickerProviderStateMixin {
  late AnimationController _fillController;
  late Animation<double> _fillAnimation;
  
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fillController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _fillAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fillController, curve: Curves.easeInOutCubic),
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fillController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_fillController.isAnimating && _fillController.value == 0) {
       _scaleController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!_fillController.isAnimating && _fillController.value == 0) {
      _scaleController.reverse();
      _startFill();
    }
  }

  void _handleTapCancel() {
    _scaleController.reverse();
  }

  void _startFill() {
    _fillController.forward(from: 0.0);
    // Delay actual action slightly to show fill effect
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: Listenable.merge([_fillAnimation, _scaleAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
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
                  // 1. Progress Fill (Background Layer)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CustomPaint(
                        painter: LiquidWavePainter(
                          _fillAnimation.value, 
                          wavePhase: _fillAnimation.value * 2 * pi, 
                          color: Colors.white.withValues(alpha: 0.15),
                          waveFrequency: 1.5,
                        ),
                      ),
                    ),
                  ),
                  // 2. Progress Fill (Foreground Layer)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CustomPaint(
                        painter: LiquidWavePainter(
                          _fillAnimation.value, 
                          wavePhase: _fillAnimation.value * 2 * pi + 1.5, 
                          color: Colors.white.withValues(alpha: 0.25),
                          waveFrequency: 1.0,
                        ),
                      ),
                    ),
                  ),
                  widget.child,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LiquidWavePainter extends CustomPainter {
  final double progress;
  final double wavePhase;
  final Color color;
  final double waveFrequency;

  LiquidWavePainter(this.progress, {
    required this.wavePhase, 
    required this.color,
    this.waveFrequency = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    // Start from bottom-left
    path.moveTo(0, size.height);
    path.lineTo(0, 0);

    // If progress is full, just fill rect
    if (progress >= 1.0) {
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
      return;
    }

    // Wavy right edge
    final baseWidth = size.width * progress;
    // We want the wave to be vertical along the advancing edge? 
    // Wait, typical liquid button fills from left to right.
    // The previous implementation had a vertical line moving right.
    
    // Let's make the wave amplitude fade out as it reaches 100%
    final amplitude = 15.0 * (1.0 - progress); 
    
    path.lineTo(baseWidth, 0);

    // Draw wave downwards
    for (double y = 0; y <= size.height; y += 2) {
      final x = baseWidth + sin((y / size.height * 4 * pi * waveFrequency) + wavePhase) * amplitude;
      path.lineTo(x, y);
    }

    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LiquidWavePainter oldDelegate) =>
      oldDelegate.progress != progress || 
      oldDelegate.wavePhase != wavePhase ||
      oldDelegate.color != color;
}
