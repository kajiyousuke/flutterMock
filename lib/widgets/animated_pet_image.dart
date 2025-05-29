import 'package:flutter/material.dart';
import '../models/fortune_pet.dart';

class AnimatedPetImage extends StatelessWidget {
  final GrowthStage stage;
  final double size;

  const AnimatedPetImage({
    super.key,
    required this.stage,
    required this.size,
  });

  String _getImagePath(GrowthStage stage) {
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

  String _getSpeechText(GrowthStage stage) {
    switch (stage) {
      case GrowthStage.egg:
        return 'ここから始まるよ…！';
      case GrowthStage.baby:
        return 'おみくじもっと引いて〜！';
      case GrowthStage.junior:
        return '運勢って奥深いね！';
      case GrowthStage.senior:
        return 'まだまだ成長できるぞ';
      case GrowthStage.god:
        return 'ついに神になったぞ…！';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 吹き出し
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Text(
            _getSpeechText(stage),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),

        // ペット画像
        Image.asset(
          _getImagePath(stage),
          height: size,
        ),
      ],
    );
  }
}
