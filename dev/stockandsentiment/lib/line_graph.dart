

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'news_model.dart';

LineChartData sampleData1(Prices prices) {
  double i = 0;
  getMax() {
    var maxArr = [];
    var highVal = 0.00;
    for (var name in prices.data) {
      if (double.parse(name.historical.close) > highVal) {
        highVal = double.parse(name.historical.close);
      }
      maxArr.add(double.parse(name.historical.close));
    }
   

    return highVal;
  }

   getMin() {
    var maxArr = [];
    var lowVal = 10000.00;
    for (var name in prices.data) {
      if (double.parse(name.historical.close) < lowVal) {
        lowVal = double.parse(name.historical.close);
      }
      maxArr.add(double.parse(name.historical.close));
    }
  

    return lowVal;
  }

  getDiff(){

  var diff = getMax() - getMin();
  var finalDiff = 0;

  if (diff < 10 ) {
    finalDiff = 1;
  }
  else if (diff < 100 ){
    finalDiff = 20;
  }

  else if (diff < 200 ){
    finalDiff = 40;
  }
  else if (diff < 400 ){
    finalDiff = 80;
  }

  else if (diff < 800 ){
    finalDiff = 160;
  }

  else if (diff < 1600 ){
    finalDiff = 320;
  }

  else if (diff < 3200 ){
    finalDiff = 640;
  }

  else {
    finalDiff = 1000;
  }
  
 return finalDiff;
 

  }

  getDiff();
  return LineChartData(
    clipToBorder: true,
    maxY: getMax() + (getDiff()/2),
    minY: getMin() - (getDiff()/2),

    //minY: getMin(),
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
            return '${value.toInt()}';
          },
        ),
        leftTitles: SideTitles(
          margin:20.0,
          
          interval: getDiff().toDouble(),
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
      ]);
}
