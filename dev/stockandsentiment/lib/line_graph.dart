import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'news_model.dart';

LineChartData sampleData1(Prices prices) {
  double i = 0;
  return LineChartData(
    
    
    gridData: const FlGridData(
      show: false,
      
      
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
          return '${value.toInt() - 1}';
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
          final val = FlSpot(i, double.parse(price.historical.close));
          i++;
          return val;
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
          show: true,
          colors: [
            Color(0xff4af699).withOpacity(0.5),
            Color(0xff4af699).withOpacity(0.0),
          ],
          gradientColorStops: [0.5, 1.0],
          gradientFrom: const Offset(0, 0),
          gradientTo: const Offset(0, 1),
        ),
      ),
    ]
  );
}
