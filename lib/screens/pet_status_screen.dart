import 'package:flutter/material.dart';
import '../models/fortune_pet.dart';

class PetStatusScreen extends StatefulWidget {
  final FortunePet pet;

  const PetStatusScreen({super.key, required this.pet});

  @override
  State<PetStatusScreen> createState() => _PetStatusScreenState();
}

class _PetStatusScreenState extends State<PetStatusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String getStageName(GrowthStage stage) {
    switch (stage) {
      case GrowthStage.egg:
        return 'たまご';
      case GrowthStage.baby:
        return 'あかちゃん';
      case GrowthStage.junior:
        return '少年';
      case GrowthStage.senior:
        return '仙人';
      case GrowthStage.god:
        return '神';
    }
  }

  String getStageImage(GrowthStage stage) {
    switch (stage) {
      case GrowthStage.egg:
        return 'assets/images/stage_egg.png';
      case GrowthStage.baby:
        return 'assets/images/stage_baby.png';
      case GrowthStage.junior:
        return 'assets/images/stage_junior.png';
      case GrowthStage.senior:
        return 'assets/images/stage_senior.png';
      case GrowthStage.god:
        return 'assets/images/stage_god.png';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stageName = getStageName(widget.pet.stage);
    final imagePath = getStageImage(widget.pet.stage);

    return Scaffold(
      appBar: AppBar(
        title: const Text('育成状況'),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '現在の進化：$stageName',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_animation.value),
                child: child,
              );
            },
            child: Image.asset(
              imagePath,
              height: 180,
            ),
          ),
          const SizedBox(height: 20),
          Text('おみくじを引いた回数：${widget.pet.totalDraws}回'),
          const SizedBox(height: 20),
          const Text('各運勢の回数：', style: TextStyle(fontSize: 18)),
          ...widget.pet.drawCounts.entries
              .map((entry) => Text('${entry.key}：${entry.value}回')),
        ],
      ),
    );
  }
}
