import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ResultScreen extends StatefulWidget {
  final String fortune;
  final String category;

  const ResultScreen({
    super.key,
    required this.fortune,
    required this.category,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // 自動再生
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getMessage(String result, String category) {
    final messages = {
      '恋愛運': {
        '大吉': '運命の出会いが訪れるかも♡',
        '中吉': 'アプローチするなら今！',
        '吉': '積極性が吉と出る予感',
        '小吉': '笑顔が恋のきっかけに',
        '凶': '焦らず自分磨きを',
      },
      '仕事運': {
        '大吉': '大きな成果が期待できる！',
        '中吉': '努力が報われる日が近い',
        '吉': '挑戦がチャンスを呼ぶ',
        '小吉': 'チームワークを大切に',
        '凶': '慎重に計画を立てて',
      },
      '金運': {
        '大吉': '思わぬ収入があるかも！',
        '中吉': '節約が功を奏する',
        '吉': '堅実な行動が吉',
        '小吉': '無駄遣いに注意',
        '凶': '財布のひもを締めよう',
      },
      '健康運': {
        '大吉': '心も体も絶好調！',
        '中吉': '軽い運動が効果的',
        '吉': '体調に気を配れば快調に',
        '小吉': '睡眠を大切に',
        '凶': '無理せず休息を',
      },
      '総合運': {
        '大吉': '今日は素晴らしい1日になる！',
        '中吉': 'コツコツ続けて吉',
        '吉': '新しいことに挑戦してみて',
        '小吉': '人との繋がりを大切に',
        '凶': '慎重に過ごすのが吉',
      }
    };

    return messages[category]?[widget.fortune] ?? '良い一日になりますように';
  }

  Color getFortuneColor(String result) {
    switch (result) {
      case '大吉':
        return Colors.redAccent;
      case '中吉':
        return Colors.orange;
      case '吉':
        return Colors.teal;
      case '小吉':
        return Colors.green;
      case '凶':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = getMessage(widget.fortune, widget.category);
    final fortuneColor = getFortuneColor(widget.fortune);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('おみくじ結果'),
        backgroundColor: fortuneColor,
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.category,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  widget.fortune,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: fortuneColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('もう一度引く'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
