import 'dart:ui';
import 'package:flutter/material.dart';

class AntiGravityBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<IconData> icons;
  final Color activeColor;
  final Color inactiveColor;
  final double maxWidth;

  const AntiGravityBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
    this.activeColor = const Color(0xFFA82E2E), // Stylish Red
    this.inactiveColor = Colors.grey,
    this.maxWidth = 500, // For desktop responsiveness
  });

  @override
  State<AntiGravityBottomNavBar> createState() => _AntiGravityBottomNavBarState();
}

class _AntiGravityBottomNavBarState extends State<AntiGravityBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8), // Glassmorphism base
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(widget.icons.length, (index) {
                    final isActive = index == widget.currentIndex;
                    
                    return GestureDetector(
                      onTap: () => widget.onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: _AntiGravityIcon(
                        icon: widget.icons[index],
                        isActive: isActive,
                        activeColor: widget.activeColor,
                        inactiveColor: widget.inactiveColor,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AntiGravityIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  const _AntiGravityIcon({
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutBack, // Smooth ease-in-out with soft bounce
      transform: Matrix4.translationValues(0, isActive ? -8 : 0, 0),
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        size: 28,
        color: isActive ? activeColor : inactiveColor,
      ),
    );
  }
}
