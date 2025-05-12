import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String fortune;

  ResultScreen({required this.fortune});

  Color getFortuneColor() {
    switch (fortune) {
      case '大吉':
        return Colors.amber;
      case '中吉':
        return Colors.lightGreen;
      case '小吉':
        return Colors.blue;
      case '末吉':
        return Colors.grey;
      case '凶':
        return Colors.black;
      default:
        return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('結果')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'あなたの運勢は……',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // アニメーション付きテキスト
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: value,
                    child: Text(
                      fortune,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: getFortuneColor(),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('もう一回引く'),
            ),
          ],
        ),
      ),
    );
  }
}
