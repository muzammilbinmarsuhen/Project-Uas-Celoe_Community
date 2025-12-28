import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/dummy_course_data.dart';
import '../../../../routes/app_routes.dart';

class MaterialTab extends StatefulWidget {
  const MaterialTab({super.key});

  @override
  State<MaterialTab> createState() => _MaterialTabState();
}

class _MaterialTabState extends State<MaterialTab> {
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
      
      // Auto-exit if empty? Optional. Let's keep it manual or empty-exit.
      if (_selectedIds.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _enterSelectionMode(String id) {
    setState(() {
      _isSelectionMode = true;
      _selectedIds.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final materials = DummyCourseData.materials;

    return Column(
      children: [
        if (_isSelectionMode)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_selectedIds.length} Dipilih', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => setState(() {
                    _isSelectionMode = false;
                    _selectedIds.clear();
                  }),
                  child: Text('Batal', style: GoogleFonts.poppins(color: Colors.red)),
                )
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: materials.length,
            itemBuilder: (context, index) {
              return _buildMaterialCard(context, materials[index], index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialCard(BuildContext context, MaterialItem item, int index) {
    final isSelected = _selectedIds.contains(item.id);

    return TweenAnimationBuilder<double>(
       tween: Tween(begin: 0.0, end: 1.0),
       duration: Duration(milliseconds: 400 + (index * 100)),
       curve: Curves.easeOutQuad,
       builder: (context, value, child) {
          return Transform.translate(
             offset: Offset(0, 50 * (1 - value)),
             child: Opacity(opacity: value, child: child),
          );
       },
       child: _ScaleableCard(
          onTap: () {
            if (_isSelectionMode) {
              _toggleSelection(item.id);
            } else {
              Navigator.pushNamed(context, AppRoutes.materialDetail, arguments: item);
            }
          },
          onLongPress: () => _enterSelectionMode(item.id),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.red.withValues(alpha: 0.05) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: isSelected ? Border.all(color: const Color(0xFFA82E2E), width: 1.5) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Illustration Placeholder
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                           child: Icon(Icons.menu_book, color: Colors.blue, size: 30),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item.meetingTitle,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.title,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.subtitle,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Status/Selection Icon
                      if (_isSelectionMode)
                        Container(
                           margin: const EdgeInsets.only(left: 8),
                           child: Icon(
                             isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                             color: isSelected ? const Color(0xFFA82E2E) : Colors.grey,
                             size: 24,
                           ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
       ),
    );
  }
}

class _ScaleableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  
  const _ScaleableCard({required this.child, required this.onTap, this.onLongPress});
  @override
  State<_ScaleableCard> createState() => _ScaleableCardState();
}

class _ScaleableCardState extends State<_ScaleableCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
     super.initState();
     _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
     _scaleAnimation = Tween(begin: 1.0, end: 0.98).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTapDown: (_) => _controller.forward(),
       onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
       },
       onTapCancel: () => _controller.reverse(),
       onLongPress: widget.onLongPress,
       child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.scale(scale: _scaleAnimation.value, child: widget.child),
       ),
    );
  }
}
