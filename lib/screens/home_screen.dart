import 'dart:math';
import 'package:flutter/material.dart';
import '../screens/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<String> fortunes = ['大吉', '中吉', '小吉', '末吉', '凶'];

  late AnimationController _controller;
  late Animation<double> _animation;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラの初期化
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // 振るような動きのアニメーション（左右に傾く）
    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _drawOmikuji(BuildContext context) async {
    if (isAnimating) return; // 二重タップ防止

    setState(() {
      isAnimating = true;
    });

    final random = Random();
    final fortune = fortunes[random.nextInt(fortunes.length)];

    // アニメーションを再生
    await _controller.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _controller.reset();

    setState(() {
      isAnimating = false;
    });

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(fortune: fortune),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('おみくじを引こう！'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _drawOmikuji(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/omikuji_box.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'おみくじをタップ！',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
