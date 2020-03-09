import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'news_model.dart';

LineChartData sampleData1(Prices prices) {
  double i = 0;
  return LineChartData(
    gridData: const FlGridData(
      show: true,
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        interval: 7,
        showTitles: true,
        textStyle: TextStyle(
          color: const Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        getTitles: (value) {
          return '${value.toInt()}';
        },
      ),
      leftTitles: SideTitles(
        interval: 10,
        showTitles: true,
        textStyle: TextStyle(
          color: const Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        getTitles: (value) {
          return '${value.floor()}';
        },
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    lineBarsData: [
      LineChartBarData(
        spots: prices.data.map((price) {
          i++;
          return FlSpot(i, price.historical.close);
        }).toList(),
        isCurved: true,
        colors: [
          Color(0xff4af699),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ],
  );
}
