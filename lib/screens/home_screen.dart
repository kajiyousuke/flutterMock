import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> fortunes = ['大吉', '中吉', '小吉', '末吉', '凶'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getFortune() {
    final random = Random();
    return fortunes[random.nextInt(fortunes.length)];
  }

  String getMessageForFortune(String fortune) {
    switch (fortune) {
      case '大吉':
        return '今日は最高の一日になるでしょう！';
      case '中吉':
        return '良いことがありますよ！';
      case '小吉':
        return 'ちょっとだけ良いことがあるかも。';
      case '末吉':
        return 'これから運が向いてくるかも！';
      case '凶':
        return '気を引き締めていきましょう。';
      default:
        return '運勢不明...もう一度試してみてください。';
    }
  }

  void _drawFortune() async {
    await _controller.forward();
    await _controller.reverse();

    String fortune = getFortune();
    String message = getMessageForFortune(fortune);

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(result: fortune, message: message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'おみくじを引こう！',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: _drawFortune,
                  child: Image.asset(
                    'assets/images/omikuji_box.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _drawFortune,
                icon: const Icon(Icons.casino),
                label: const Text('おみくじを引く'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
