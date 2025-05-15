import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String fortune;
  final String category;

  const ResultScreen({
    super.key,
    required this.fortune,
    required this.category,
  });

  String getMessage(String result, String category) {
    final messages = {
      '恋愛運': {
        '大吉': '運命の出会いが訪れるかも♡',
        '中吉': 'アプローチするなら今！',
        '小吉': '笑顔が恋のきっかけに',
        '末吉': '相手の話をよく聞こう',
        '凶': '焦らず自分磨きを',
      },
      '仕事運': {
        '大吉': '大きな成果が期待できる！',
        '中吉': '努力が報われる日が近い',
        '小吉': 'チームワークを大切に',
        '末吉': '地道な努力が鍵',
        '凶': '慎重に計画を立てて',
      },
      '金運': {
        '大吉': '思わぬ収入があるかも！',
        '中吉': '節約が功を奏する',
        '小吉': '無駄遣いに注意',
        '末吉': '計画的に使おう',
        '凶': '財布のひもを締めよう',
      },
      '健康運': {
        '大吉': '心も体も絶好調！',
        '中吉': '軽い運動が効果的',
        '小吉': '睡眠を大切に',
        '末吉': '栄養バランスを意識して',
        '凶': '無理せず休息を',
      },
      '総合運': {
        '大吉': '今日は素晴らしい1日になる！',
        '中吉': 'コツコツ続けて吉',
        '小吉': '人との繋がりを大切に',
        '末吉': '一歩引いて様子を見よう',
        '凶': '慎重に過ごすのが吉',
      }
    };

    return messages[category]?[result] ?? '良い一日になりますように';
  }

  Color getFortuneColor(String result) {
    switch (result) {
      case '大吉':
        return Colors.redAccent;
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

  @override
  Widget build(BuildContext context) {
    final message = getMessage(fortune, category);
    final fortuneColor = getFortuneColor(fortune);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('おみくじ結果'),
        backgroundColor: fortuneColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              fortune,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: fortuneColor,
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
    );
  }
}
