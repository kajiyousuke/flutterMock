import '../models/fortune.dart';
import 'dart:math';

class FortuneData {
  static final Map<String, List<Fortune>> fortunesByCategory = {
    '総合運': [Fortune(text: '大吉', color: 'red'), Fortune(text: '中吉', color: 'orange')],
    '恋愛運': [Fortune(text: '吉', color: 'green'), Fortune(text: '凶', color: 'blue')],
    '仕事運': [Fortune(text: '大吉', color: 'red'), Fortune(text: '末吉', color: 'purple')],
    '金運': [Fortune(text: '中吉', color: 'orange'), Fortune(text: '小吉', color: 'yellow')],
    '健康運': [Fortune(text: '吉', color: 'green'), Fortune(text: '大凶', color: 'black')],
  };

  static Fortune getRandomFortune({required String category}) {
    final list = fortunesByCategory[category] ?? fortunesByCategory['総合運']!;
    final randomIndex = Random().nextInt(list.length);
    return list[randomIndex];
  }
}
