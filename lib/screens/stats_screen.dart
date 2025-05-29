import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/fortune_pet.dart';

class StatsScreen extends StatelessWidget {
  final FortunePet pet;

  StatsScreen({required this.pet});

  @override
  Widget build(BuildContext context) {
    final fortuneCounts = pet.fortuneCounts;

    final labels = ['大吉', '中吉', '吉', '小吉', '凶'];
    final values = [
      fortuneCounts['大吉'] ?? 0,
      fortuneCounts['中吉'] ?? 0,
      fortuneCounts['吉'] ?? 0,
      fortuneCounts['小吉'] ?? 0,
      fortuneCounts['凶'] ?? 0,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('運勢ランキング'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: (values.reduce((a, b) => a > b ? a : b) + 2).toDouble(),
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final index = value.toInt();
                    if (index < labels.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(labels[index], style: TextStyle(fontSize: 12)),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            barGroups: List.generate(labels.length, (index) {
              return BarChartGroupData(x: index, barRods: [
                BarChartRodData(
                  toY: values[index].toDouble(),
                  color: Colors.blue,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                )
              ]);
            }),
          ),
        ),
      ),
    );
  }
}
