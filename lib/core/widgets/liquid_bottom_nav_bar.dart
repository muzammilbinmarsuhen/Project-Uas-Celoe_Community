import 'package:flutter/material.dart';

class LmsBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<IconData> icons;

  const LmsBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFFB22222), // Maroon
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
             BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isActive = index == currentIndex;
              return GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.opaque,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: isActive ? 1.2 : 1.0),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: isActive 
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          )
                        : null,
                        child: Icon(
                          icons[index],
                          color: isActive ? const Color(0xFFB22222) : Colors.white.withValues(alpha: 0.7),
                          size: 26,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
