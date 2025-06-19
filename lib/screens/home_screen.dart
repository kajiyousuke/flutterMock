import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/fortune_data.dart';
import '../models/fortune.dart';
import '../models/fortune_pet.dart';
import 'result_screen.dart';
import 'pet_status_screen.dart';
import 'stats_screen.dart';
import '../widgets/animated_pet_image.dart';

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
  late Animation<double> _shakeAnimation;
  late FortunePet pet;
  String petName = '';

  @override
  void initState() {
    super.initState();
    pet = FortunePet.initial();
    petName = pet.name;
    _loadPetName();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  Future<void> _loadPetName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      petName = prefs.getString('pet_name') ?? pet.name;
      pet.name = petName;
    });
  }

  Future<void> _savePetName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pet_name', name);
    setState(() {
      petName = name;
      pet.name = name;
    });
  }

  void _showNameInputDialog() {
    final controller = TextEditingController(text: petName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ペットに名前をつけよう'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'ペットの名前を入力'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                _savePetName(newName);
              }
              Navigator.pop(context);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
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
        return FortuneCategory.health;
      default:
        return FortuneCategory.general;
    }
  }

  void recordFortuneToPet(String result) {
    setState(() {
      pet.recordFortune(result);
    });
  }

  void _drawFortune() async {
    setState(() => isShaking = true);

    _shakeController.repeat(reverse: true);
    await Future.delayed(const Duration(milliseconds: 800));
    _shakeController.stop();

    final categoryEnum = _mapCategoryLabelToEnum(selectedCategory);
    final fortune = FortuneData.getRandomFortune(category: categoryEnum);

    recordFortuneToPet(fortune.text);

    if (!mounted) return;

    final updatedPet = await Navigator.push<FortunePet>(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          fortune: fortune.text,
          category: selectedCategory,
          pet: pet,
        ),
      ),
    );

    if (updatedPet != null) {
      setState(() {
        pet = updatedPet;
      });
    }

    setState(() => isShaking = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('ホーム'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showNameInputDialog,
            tooltip: '名前を変更',
          )
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            // 左側：操作UI
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
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
                    const SizedBox(height: 36),
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
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PetStatusScreen(pet: pet),
                          ),
                        );
                      },
                      icon: const Icon(Icons.pets),
                      label: const Text('神様を見る'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade100,
                        foregroundColor: Colors.purple.shade800,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StatsScreen(pet: pet),
                          ),
                        );
                      },
                      icon: const Icon(Icons.bar_chart),
                      label: const Text('運勢ランキング'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade100,
                        foregroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // 右側：ペット＋吹き出し
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedPetImage(
                    stage: pet.stage,
                    size: 140,
                  ),
                  const SizedBox(height: 8),
                  Text('名前：$petName', style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
