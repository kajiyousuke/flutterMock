import 'package:flutter/material.dart';

class AnimatedOmikujiBox extends StatefulWidget {
  final VoidCallback onTap;
  final String imagePath;
  final double size;

  const AnimatedOmikujiBox({
    super.key,
    required this.onTap,
    required this.imagePath,
    this.size = 200.0,
  });

  @override
  State<AnimatedOmikujiBox> createState() => _AnimatedOmikujiBoxState();
}

class _AnimatedOmikujiBoxState extends State<AnimatedOmikujiBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _handleTap() {
    _controller.forward(from: 0.0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Image.asset(
          widget.imagePath,
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
