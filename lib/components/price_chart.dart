import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceChart extends StatelessWidget {

  const PriceChart( {Key? key} ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: LineChart( LineChartData(
          titlesData: FlTitlesData(
              show: true,
              rightTitles: SideTitles(showTitles: false),
              topTitles: SideTitles(showTitles: false)
          ),
          borderData: FlBorderData( show: false ),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  const FlSpot( 0, 1 ),
                  const FlSpot( 1, 3 ),
                  const FlSpot( 2, 10 ),
                  const FlSpot( 3, 7 ),
                  const FlSpot( 4, 12 ),
                  const FlSpot( 5, 13 ),
                  const FlSpot( 6, 17 ),
                  const FlSpot( 7, 15 ),
                  const FlSpot( 8, 20 ),
                ],
                isCurved: true,
                colors: [Colors.green]
            )
          ]
      )),
    );
  }

}