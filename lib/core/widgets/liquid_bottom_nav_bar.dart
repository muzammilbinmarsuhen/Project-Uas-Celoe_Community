import 'package:flutter/material.dart';

class LiquidBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<IconData> icons;

  const LiquidBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
  });

  @override
  State<LiquidBottomNavBar> createState() => _LiquidBottomNavBarState();
}

class _LiquidBottomNavBarState extends State<LiquidBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 320),
      vsync: this,
    );

    _positionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Cubic(0.4, 0.0, 0.2, 1.0),
      ),
    );

    if (widget.currentIndex >= 0) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(LiquidBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _controller.reset();
      _controller.forward();
    }
  }

  double _getRingLeft(int index, Size size) {
    final itemWidth = size.width / widget.icons.length;
    return index * itemWidth + (itemWidth / 2) - 20; // Center the 40px ring
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          // Background Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFA82E2E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),

          // Sliding Green Ring Indicator with Active Icon
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              final targetLeft = _getRingLeft(widget.currentIndex, size);
              final previousLeft = _getRingLeft(_previousIndex, size);
              final currentLeft = _positionAnimation.value * (targetLeft - previousLeft) + previousLeft;

              return Positioned(
                bottom: 20,
                left: currentLeft,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      child: Icon(
                        widget.icons[widget.currentIndex],
                        key: ValueKey<int>(widget.currentIndex),
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Inactive Icons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(widget.icons.length, (index) {
                  final bool isActive = index == widget.currentIndex;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => widget.onTap(index),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Icon or SizedBox for active
                          isActive
                              ? const SizedBox(height: 24)
                              : Icon(
                                  widget.icons[index],
                                  color: Colors.white.withValues(alpha: 0.6),
                                  size: 24,
                                ),
                          const SizedBox(height: 16),
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
}
