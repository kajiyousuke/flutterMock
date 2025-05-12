import 'dart:math';
import 'package:flutter/material.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  final List<String> fortunes = [
    '大吉',
    '中吉',
    '小吉',
    '末吉',
    '凶',
  ];

  String getRandomFortune() {
    final random = Random();
    return fortunes[random.nextInt(fortunes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('おみくじアプリ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1000),
              child: Icon(Icons.auto_awesome, size: 100, color: Colors.redAccent),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String fortune = getRandomFortune();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(fortune: fortune),
                  ),
                );
              },
              child: Text('おみくじを引く'),
            ),
          ],
        ),
      ),
    );
  }
}
