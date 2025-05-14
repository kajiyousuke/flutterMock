import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String result;
  final String message;

  const ResultScreen({super.key, required this.result, required this.message});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Color get backgroundColor {
    switch (widget.result) {
      case '大吉':
        return Colors.red.shade100;
      case '中吉':
        return Colors.orange.shade100;
      case '小吉':
        return Colors.green.shade100;
      case '末吉':
        return Colors.blue.shade100;
      case '凶':
        return Colors.grey.shade300;
      default:
        return Colors.white;
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildAnimation() {
    switch (widget.result) {
      case '大吉':
        return ScaleTransition(
          scale: _animation,
          child: Icon(Icons.star, size: 120, color: Colors.amber),
        );
      case '中吉':
        return RotationTransition(
          turns: _animation,
          child: Icon(Icons.sunny, size: 100, color: Colors.orange),
        );
      case '小吉':
        return FadeTransition(
          opacity: _animation,
          child: Icon(Icons.favorite, size: 90, color: Colors.pink),
        );
      case '末吉':
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(_animation),
          child: Icon(Icons.emoji_emotions, size: 90, color: Colors.blue),
        );
      case '凶':
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(_animation),
          child: Icon(Icons.warning, size: 100, color: Colors.black45),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('おみくじ結果'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildAnimation(),
              const SizedBox(height: 24),
              Text(
                widget.result,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                widget.message,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // ホームに戻る
                },
                icon: const Icon(Icons.refresh),
                label: const Text('もう一度引く'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.redAccent,
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
