import 'package:flutter/material.dart';
import '../widgets/animated_omikuji_box.dart';
import '../widgets/confetti_widget.dart';
import 'home_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigateToHome(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Stack(
        children: [
          const FullScreenConfetti(), // 🎉紙吹雪エフェクト
          Center(
            child: AnimatedOmikujiBox(
              imagePath: 'assets/images/omikuji_box.png',
              onTap: () => _navigateToHome(context), // タップでホームへ遷移
              size: 220,
            ),
          ),
          const Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Text(
              '画面をタップして\nおみくじを引こう！',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
