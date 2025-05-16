import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FullScreenConfetti extends StatefulWidget {
  const FullScreenConfetti({super.key});

  @override
  State<FullScreenConfetti> createState() => _FullScreenConfettiState();
}

class _FullScreenConfettiState extends State<FullScreenConfetti> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 50,
            maxBlastForce: 20,
            minBlastForce: 5,
            gravity: 0.3,
            emissionFrequency: 0.05,
            colors: const [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.orange,
              Colors.purple,
            ],
            createParticlePath: _drawStar,
          ),
        ),
      ],
    );
  }

  // 星型の紙吹雪
  Path _drawStar(Size size) {
    // 星型のパスを描く
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final path = Path();
    final angle = 360 / numberOfPoints;

    Offset center = Offset(halfWidth, halfWidth);
    for (int i = 0; i <= numberOfPoints; i++) {
      double outerAngle = degToRad(i * angle);
      double innerAngle = degToRad(i * angle + angle / 2);

      path.lineTo(
        center.dx + externalRadius * cos(outerAngle),
        center.dy + externalRadius * sin(outerAngle),
      );
      path.lineTo(
        center.dx + internalRadius * cos(innerAngle),
        center.dy + internalRadius * sin(innerAngle),
      );
    }

    path.close();
    return path;
  }
}
