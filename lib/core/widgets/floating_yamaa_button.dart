import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/main_nav_bar/main_nav_bar.dart';

class FloatingYamaaButton extends StatefulWidget {
  const FloatingYamaaButton({
    Key? key,
    this.initialPosition,
    this.onPositionChanged,
    this.isDraggable = true,
    this.size = 65.0,
    this.bottomOffset = 30.0,
    this.horizontalOffset = 20.0,
  }) : super(key: key);

  final Offset? initialPosition;
  final ValueChanged<Offset>? onPositionChanged;
  final bool isDraggable;
  final double size;
  final double bottomOffset;
  final double horizontalOffset;

  @override
  State<FloatingYamaaButton> createState() => _FloatingYamaaButtonState();
}

class _FloatingYamaaButtonState extends State<FloatingYamaaButton>
    with SingleTickerProviderStateMixin {
  late Offset _position;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Set initial position based on language and provided position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialPosition();
    });
  }

  void _setInitialPosition() {
    final screenSize = MediaQuery.of(context).size;
    final bool isArabic = Get.locale?.languageCode == 'ar';

    if (widget.initialPosition != null) {
      _position = widget.initialPosition!;
    } else {
      // Default position based on language
      _position = Offset(
        isArabic 
          ? widget.horizontalOffset 
          : screenSize.width - widget.size - widget.horizontalOffset,
        screenSize.height - widget.size - widget.bottomOffset - kBottomNavigationBarHeight,
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _isDragging = true;
    });
    _animationController.forward();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isDraggable) return;
    final screenSize = MediaQuery.of(context).size;
    
    setState(() {
      _position = Offset(
        (_position.dx + details.delta.dx).clamp(0, screenSize.width - widget.size),
        (_position.dy + details.delta.dy).clamp(0, screenSize.height - widget.size - kBottomNavigationBarHeight),
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isDraggable) return;
    setState(() {
      _isDragging = false;
    });
    _animationController.reverse();
    
    // Snap to edges for better UX
    _snapToEdge();
    
    // Notify parent about position change
    widget.onPositionChanged?.call(_position);
  }

  void _snapToEdge() {
    final screenSize = MediaQuery.of(context).size;
    final screenCenter = screenSize.width / 2;
    
    // Snap to left or right edge based on current position
    final newX = _position.dx < screenCenter 
      ? widget.horizontalOffset 
      : screenSize.width - widget.size - widget.horizontalOffset;
    
    setState(() {
      _position = Offset(newX, _position.dy);
    });
  }

  void _onTap() {
    // Navigate to main navigation bar
    Get.offAll(() => const AppBottomBar());
  }

  @override
  Widget build(BuildContext context) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      bottom: 21,
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        onTap: _onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: resolvedButtonColor.withOpacity(_isDragging ? 0.6 : 0.4),
                      blurRadius: _isDragging ? 30 : 25,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(_isDragging ? 0.25 : 0.15),
                      blurRadius: _isDragging ? 25 : 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: resolvedButtonColor.withOpacity(_isDragging ? 0.8 : 0.6),
                    width: _isDragging ? 4 : 3,
                  ),
                ),
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(_isDragging ? 10 : 12),
                    child: Image.asset(
                      'assets/images/yamaLogo1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Simplified version for specific use cases
class SimpleFloatingYamaaButton extends StatelessWidget {
  const SimpleFloatingYamaaButton({
    Key? key,
    this.bottom = 30.0,
    this.left,
    this.right,
    this.size = 65.0,
    this.onTap,
  }) : super(key: key);

  final double bottom;
  final double? left;
  final double? right;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color resolvedButtonColor =
        buttonColor is Color ? buttonColor as Color : const Color(0xFFE47B39);
    final bool isArabic = Get.locale?.languageCode == 'ar';

    return Positioned(
      bottom: bottom,
      left: left ?? (isArabic ? 20 : null),
      right: right ?? (isArabic ? null : 20),
      child: InkWell(
        onTap: onTap ?? () => Get.offAll(() => const AppBottomBar()),
        borderRadius: BorderRadius.circular(size / 2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: resolvedButtonColor.withOpacity(0.4),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: resolvedButtonColor.withOpacity(0.6),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/images/yamaLogo1.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Extension for easy positioning
extension FloatingYamaaButtonHelper on Widget {
  Widget withFloatingYamaaButton({
    bool isDraggable = true,
    double size = 65.0,
    double bottomOffset = 30.0,
    double horizontalOffset = 20.0,
    Offset? initialPosition,
    ValueChanged<Offset>? onPositionChanged,
  }) {
    return Stack(
      children: [
        this,
        FloatingYamaaButton(
          isDraggable: isDraggable,
          size: size,
          bottomOffset: bottomOffset,
          horizontalOffset: horizontalOffset,
          initialPosition: initialPosition,
          onPositionChanged: onPositionChanged,
        ),
      ],
    );
  }

  Widget withSimpleFloatingYamaaButton({
    double bottom = 30.0,
    double? left,
    double? right,
    double size = 65.0,
    VoidCallback? onTap,
  }) {
    return Stack(
      children: [
        this,
        SimpleFloatingYamaaButton(
          bottom: bottom,
          left: left,
          right: right,
          size: size,
          onTap: onTap,
        ),
      ],
    );
  }
}