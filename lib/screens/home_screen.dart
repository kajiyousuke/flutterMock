import 'package:flutter/material.dart';
import '../utils/fortune_data.dart';
import '../models/fortune.dart';
import '../models/fortune_pet.dart'; // ← 追加
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> categories = [
    {'label': '総合運', 'icon': Icons.star},
    {'label': '恋愛運', 'icon': Icons.favorite},
    {'label': '仕事運', 'icon': Icons.work},
    {'label': '金運', 'icon': Icons.attach_money},
    {'label': '健康運', 'icon': Icons.health_and_safety},
  ];

  String selectedCategory = '総合運';
  bool isShaking = false;

  late AnimationController _shakeController;
  late AnimationController _lidController;
  late Animation<double> _shakeAnimation;

  // 🐣 育成ペットの状態
  FortunePet _pet = FortunePet.initial();

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    _lidController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _lidController.dispose();
    super.dispose();
  }

  FortuneCategory _mapCategoryLabelToEnum(String label) {
    switch (label) {
      case '総合運':
        return FortuneCategory.general;
      case '恋愛運':
        return FortuneCategory.love;
      case '仕事運':
        return FortuneCategory.work;
      case '金運':
        return FortuneCategory.money;
      case '健康運':
        return FortuneCategory.general;
      default:
        return FortuneCategory.general;
    }
  }

  void _drawFortune() async {
    setState(() => isShaking = true);

    _shakeController.repeat(reverse: true);
    await Future.delayed(const Duration(milliseconds: 800));
    _shakeController.stop();

    _lidController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _lidController.reverse();

    final categoryEnum = _mapCategoryLabelToEnum(selectedCategory);
    final fortune = FortuneData.getRandomFortune(category: categoryEnum);

    // 🐣 成長データを更新
    _pet.recordFortune(fortune.text);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          fortune: fortune.text,
          category: selectedCategory,
          pet: _pet, // ← これで今後表示画面に成長段階を表示可能
        ),
      ),
    );

    setState(() => isShaking = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'カテゴリを選んでおみくじを引こう！',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

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
                      backgroundColor:
                          isSelected ? Colors.pink : Colors.grey[300],
                      foregroundColor:
                          isSelected ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 40),

            GestureDetector(
              onTap: isShaking ? null : _drawFortune,
              child: AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: isShaking ? _shakeAnimation.value : 0,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/omikuji_box.png',
                  width: 140,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
