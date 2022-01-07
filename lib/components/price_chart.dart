import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChartGradientColor {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
}

  class PriceChart extends StatelessWidget {

  double price = 0.0;

  PriceChart( double price, {Key? key} ) : super(key: key);

  double get currentPrice => price;

  @override
  Widget build( BuildContext context ) {

  return SizedBox(
    width: double.infinity,
    height: 200,
    child: LineChart( LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );},
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
          },),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 3:
                return 'OCT';
                case 6:
                  return 'NOV';
                  case 9:
                    return 'DEC';
                    case 12:
                      return 'JAN';
            }
            return '';
            },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
                case 3:
                  return '30k';
                  case 5:
                    return '50k';
            }
            return '';
            },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 14,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, currentPrice * 2 ),
            FlSpot(1, currentPrice * 2.2 ),
            FlSpot(2, currentPrice * 1.5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 4),
            FlSpot(7, 4),
            FlSpot(8, 4),
            FlSpot(9, 4),
            FlSpot(10, 4),
            FlSpot(11, 4),
            FlSpot(12, 4),
            FlSpot(13, 4),

          ],
          isCurved: true,
          colors: _LineChartGradientColor().gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
            _LineChartGradientColor().gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    ),),
  );
  }
}