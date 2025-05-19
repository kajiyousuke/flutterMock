import 'package:flutter/material.dart';
import '../utils/fortune_data.dart'; 
import '../models/fortune.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'label': '総合運', 'icon': Icons.star},
    {'label': '恋愛運', 'icon': Icons.favorite},
    {'label': '仕事運', 'icon': Icons.work},
    {'label': '金運', 'icon': Icons.attach_money},
    {'label': '健康運', 'icon': Icons.health_and_safety},
  ];

  String selectedCategory = '総合運';
  bool isShaking = false;

  void _drawFortune() async {
    setState(() {
      isShaking = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    final fortune = FortuneData.getRandomFortune(category: selectedCategory);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(fortune: fortune),
      ),
    );

    setState(() {
      isShaking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Text(
            'カテゴリを選んでおみくじを引こう！',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // ✅ 横並びカテゴリボタン with アイコン
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: categories.map((category) {
                final isSelected = selectedCategory == category['label'];
                return ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      selectedCategory = category['label'];
                    });
                  },
                  icon: Icon(category['icon'], size: 18),
                  label: Text(category['label']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.pink : Colors.grey[300],
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 40),

          // 🎲 おみくじ箱（揺れるアニメーション）
          GestureDetector(
            onTap: isShaking ? null : _drawFortune,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              transform: isShaking
                  ? Matrix4.rotationZ(0.05)
                  : Matrix4.rotationZ(0),
              child: Image.asset(
                'assets/images/omikuji_box.png',
                width: 140,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
