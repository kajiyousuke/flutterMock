import 'package:flutter/material.dart';
import '../models/fortune_pet.dart';

class AnimatedPetImage extends StatefulWidget {
  final GrowthStage stage;
  final double size;

  const AnimatedPetImage({
    super.key,
    required this.stage,
    this.size = 140,
  });

  @override
  State<AnimatedPetImage> createState() => _AnimatedPetImageState();
}

class _AnimatedPetImageState extends State<AnimatedPetImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _setupAnimations(widget.stage);
  }

  void _setupAnimations(GrowthStage stage) {
    switch (stage) {
      case GrowthStage.egg:
        _moveAnimation = Tween<double>(begin: -6, end: 6).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _scaleAnimation = AlwaysStoppedAnimation(1.0);
        break;
      case GrowthStage.baby:
        _moveAnimation = Tween<double>(begin: 0, end: 10).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _scaleAnimation = AlwaysStoppedAnimation(1.0);
        break;
      case GrowthStage.junior:
        _moveAnimation = Tween<double>(begin: -8, end: 8).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case GrowthStage.senior:
        _moveAnimation = Tween<double>(begin: -5, end: 5).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case GrowthStage.god:
        _moveAnimation = Tween<double>(begin: -8, end: 8).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _scaleAnimation = Tween<double>(begin: 0.95, end: 1.1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
    }
  }

  String _getImagePath(GrowthStage stage) {
    switch (stage) {
      case GrowthStage.egg:
        return 'assets/images/stage_egg.png';
      case GrowthStage.baby:
        return 'assets/images/stage_baby.png';
      case GrowthStage.junior:
        return 'assets/images/stage_junior.png';
      case GrowthStage.senior:
        return 'assets/images/stage_senior.png';
      case GrowthStage.god:
        return 'assets/images/stage_god.png';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _getImagePath(widget.stage);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_moveAnimation.value, _moveAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: Image.asset(
        imagePath,
        height: widget.size,
      ),
    );
  }
}
