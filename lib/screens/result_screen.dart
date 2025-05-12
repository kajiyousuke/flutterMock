import 'dart:math' as math;
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String fortune;

  const ResultScreen({super.key, required this.fortune});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    if (widget.fortune == '凶') {
      _shakeController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Color getFortuneColor() {
    switch (widget.fortune) {
      case '大吉':
        return Colors.red;
      case '中吉':
        return Colors.orange;
      case '小吉':
        return Colors.green;
      case '末吉':
        return Colors.blue;
      case '凶':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  String getMessageForFortune(String fortune) {
    final messages = {
      '大吉': [
        '今日は最高の一日になりそう！',
        'チャンスを逃さずに行動してみよう！',
      ],
      '中吉': [
        '良いことがじわじわと近づいています。',
        '焦らず落ち着いて行動すると吉。',
      ],
      '小吉': [
        '小さな幸せを見逃さないでね。',
        '穏やかな気持ちで過ごそう。',
      ],
      '末吉': [
        '徐々に運が開けてくるかも。',
        '気長に待つのも大事。',
      ],
      '凶': [
        '慎重に行動すれば回避できます！',
        '今日は無理せず、ゆっくり過ごして。',
      ],
    };

    final list = messages[fortune];
    if (list == null || list.isEmpty) return '';
    list.shuffle();
    return list.first;
  }

  Widget buildAnimatedFortune() {
    switch (widget.fortune) {
      case '大吉':
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.1, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Transform.scale(
                scale: value * 1.5,
                child: Text(
                  widget.fortune,
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: getFortuneColor(),
                    shadows: [
                      Shadow(
                        blurRadius: 18,
                        color: Colors.yellowAccent.withOpacity(0.8),
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      case '中吉':
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value,
                child: Text(
                  widget.fortune,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: getFortuneColor(),
                  ),
                ),
              ),
            );
          },
        );
      case '小吉':
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.7, end: 1.0),
          duration: const Duration(milliseconds: 900),
          curve: Curves.bounceOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: Text(
                  widget.fortune,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: getFortuneColor(),
                  ),
                ),
              ),
            );
          },
        );
      case '末吉':
        return TweenAnimationBuilder<Offset>(
          tween: Tween(begin: const Offset(0, -0.5), end: Offset.zero),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: value * 50,
              child: Opacity(
                opacity: 1.0 - value.dy.abs(),
                child: Text(
                  widget.fortune,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: getFortuneColor(),
                  ),
                ),
              ),
            );
          },
        );
      case '凶':
        return AnimatedBuilder(
          animation: _shakeController,
          builder: (context, child) {
            double offset =
                math.sin(_shakeController.value * 2 * math.pi) * 8;
            return Transform.translate(
              offset: Offset(offset, 0),
              child: Text(
                widget.fortune,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: getFortuneColor(),
                ),
              ),
            );
          },
        );
      default:
        return Text(
          widget.fortune,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: getFortuneColor(),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('おみくじ結果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildAnimatedFortune(),
            const SizedBox(height: 24),
            Text(
              getMessageForFortune(widget.fortune),
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('もう一度引く'),
            ),
          ],
        ),
      ),
    );
  }
}
