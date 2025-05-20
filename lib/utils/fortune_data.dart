import '../models/fortune.dart';
import 'dart:math';

class FortuneData {
  static final Map<FortuneCategory, List<Fortune>> fortunesByCategory = {
    FortuneCategory.general: [
      Fortune(text: '大吉', color: 'red'),
      Fortune(text: '中吉', color: 'orange'),
      Fortune(text: '吉', color: 'green'),
      Fortune(text: '小吉', color: 'blue'),
      Fortune(text: '凶', color: 'grey'),
    ],
    FortuneCategory.love: [
      Fortune(text: '大吉', color: 'red'),
      Fortune(text: '中吉', color: 'orange'),
      Fortune(text: '吉', color: 'pink'),
      Fortune(text: '小吉', color: 'purple'),
      Fortune(text: '凶', color: 'grey'),
    ],
    FortuneCategory.work: [
      Fortune(text: '大吉', color: 'red'),
      Fortune(text: '中吉', color: 'orange'),
      Fortune(text: '吉', color: 'green'),
      Fortune(text: '小吉', color: 'blue'),
      Fortune(text: '凶', color: 'grey'),
    ],
    FortuneCategory.money: [
      Fortune(text: '大吉', color: 'red'),
      Fortune(text: '中吉', color: 'orange'),
      Fortune(text: '吉', color: 'yellow'),
      Fortune(text: '小吉', color: 'lightGreen'),
      Fortune(text: '凶', color: 'grey'),
    ],
    FortuneCategory.health: [
      Fortune(text: '大吉', color: 'red'),
      Fortune(text: '中吉', color: 'orange'),
      Fortune(text: '吉', color: 'lightBlue'),
      Fortune(text: '小吉', color: 'teal'),
      Fortune(text: '凶', color: 'grey'),
    ],
  };

  static Fortune getRandomFortune({required FortuneCategory category}) {
    final list = fortunesByCategory[category] ?? fortunesByCategory[FortuneCategory.general]!;
    final randomIndex = Random().nextInt(list.length);
    return list[randomIndex];
  }
}
