import 'fortune.dart'; // FortuneCategory をここから使う

enum GrowthStage {
  egg,
  baby,
  junior,
  senior,
  god,
}

class FortunePet {
  int totalDraws;              // 総おみくじ回数
  Map<String, int> drawCounts; // 各運勢の回数 {'大吉': 3, '中吉': 2, ...}
  GrowthStage stage;           // 現在の成長段階

  FortunePet({
    required this.totalDraws,
    required this.drawCounts,
    required this.stage,
  });

  // デフォルト状態（はじめてアプリを開いたとき）
  factory FortunePet.initial() {
    return FortunePet(
      totalDraws: 0,
      drawCounts: {
        '大吉': 0,
        '中吉': 0,
        '吉': 0,
        '小吉': 0,
        '凶': 0,
      },
      stage: GrowthStage.egg,
    );
  }

  // 成長条件ロジック（チューニング可能）
  void evaluateGrowth() {
    if (totalDraws >= 20) {
      stage = GrowthStage.god;
    } else if (totalDraws >= 15) {
      stage = GrowthStage.senior;
    } else if (totalDraws >= 10) {
      stage = GrowthStage.junior;
    } else if (totalDraws >= 5) {
      stage = GrowthStage.baby;
    } else {
      stage = GrowthStage.egg;
    }
  }

  // 運勢を記録・成長をチェック
  void recordFortune(String result) {
    totalDraws++;
    if (drawCounts.containsKey(result)) {
      drawCounts[result] = drawCounts[result]! + 1;
    }
    evaluateGrowth();
  }

  // グラフなどで使用するために counts を返す getter
  Map<String, int> get fortuneCounts => drawCounts;

  // 現在のステージのラベルを返す
  String get stageLabel {
    switch (stage) {
      case GrowthStage.egg:
        return 'たまご';
      case GrowthStage.baby:
        return '赤ちゃん';
      case GrowthStage.junior:
        return '少年 / 少女';
      case GrowthStage.senior:
        return '仙人';
      case GrowthStage.god:
        return '神様';
    }
  }

  // JSONへ保存
  Map<String, dynamic> toJson() {
    return {
      'totalDraws': totalDraws,
      'drawCounts': drawCounts,
      'stage': stage.index,
    };
  }

  // JSONから読み込み
  factory FortunePet.fromJson(Map<String, dynamic> json) {
    return FortunePet(
      totalDraws: json['totalDraws'],
      drawCounts: Map<String, int>.from(json['drawCounts']),
      stage: GrowthStage.values[json['stage']],
    );
  }

  // カテゴリラベルから FortuneCategory を取得
  FortuneCategory getCategoryEnumFromLabel(String label) {
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
}
