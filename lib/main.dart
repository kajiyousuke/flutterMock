import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const OmikujiApp());
}

class OmikujiApp extends StatelessWidget {
  const OmikujiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'おみくじアプリ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        scaffoldBackgroundColor: Colors.pink.shade50,
      ),
      home: const SplashScreen(),
    );
  }
}
