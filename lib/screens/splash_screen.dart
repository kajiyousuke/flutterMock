import 'package:flutter/material.dart';
import '../widgets/animated_omikuji_box.dart';
import '../widgets/confetti_widget.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ⏱ 2秒後に自動でホーム画面へ遷移
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
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
              onTap: () {}, // 自動遷移なのでタップ不要
              size: 220,
            ),
          ),
          const Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Text(
              'おみくじを準備中...',
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
