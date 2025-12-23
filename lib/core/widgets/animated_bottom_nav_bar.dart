import 'package:flutter/material.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    // Total items
    const int itemCount = 3;
    final double itemWidth = size.width / itemCount;

    return Container(
      height: 80, // Fixed height for area including floating items
      color: Colors.transparent, // Transparent to allow floating effect if needed, but we essentially stick to bottom
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. Background Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70, // Actual bar height
              decoration: const BoxDecoration(
                color: Color(0xFFA82E2E), // Primary Red
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, -5),
                  )
                ],
              ),
            ),
          ),

          // 2. Sliding Indicator (The "Blob" / "Curve")
          // We animate the "Left" property to move it.
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            bottom: 15, // Centered vertically relative to the bar height
            left: currentIndex * itemWidth + (itemWidth / 2) - 28, // Center of the item width minus half indicator width
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),

          // 3. Icons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 70,
              child: Row(
                children: List.generate(itemCount, (index) {
                  final bool isActive = index == currentIndex;
                  
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: Stack(
                         clipBehavior: Clip.none,
                         alignment: Alignment.center,
                         children: [
                           // Label (Optional - below)
                           /*
                           if (isActive)
                             Positioned(
                               bottom: 8,
                               child: Text("Home", ...),
                             ),
                            */
                            
                           // The Icon
                           AnimatedContainer(
                             duration: const Duration(milliseconds: 300),
                             curve: Curves.easeOutBack,
                             // Move up if active (Floating effect)
                             transform: Matrix4.translationValues(0, isActive ? -20 : 0, 0),
                             child: AnimatedScale(
                               duration: const Duration(milliseconds: 300),
                               scale: isActive ? 1.2 : 1.0,
                               child: Icon(
                                 _getIcon(index),
                                 size: 28,
                                 // Active: Red (to contrast with White indicator)
                                 // Inactive: White transparent
                                 color: isActive ? const Color(0xFFA82E2E) : Colors.white.withValues(alpha: 0.6),
                               ),
                             ),
                           ),
                         ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0: return Icons.home_rounded;
      case 1: return Icons.school_rounded;
      case 2: return Icons.notifications_rounded;
      default: return Icons.home_rounded;
    }
  }
}
