import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceChart extends StatelessWidget {

  String coinSymbol = '';
  double coinPrice = 0.0;

  PriceChart(this.coinSymbol, this.coinPrice, {Key? key}) : super(key: key);

  String get symbol => coinSymbol;
  double get price => coinPrice;

  @override
  Widget build( BuildContext context ) {
    return SfCartesianChart(
      title: ChartTitle( text: symbol + "/USD price history",
      textStyle: const TextStyle(
        color: Colors.white,
      ),
      backgroundColor: Colors.deepPurple),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries> [
        LineSeries<PriceData, String>(
          dataSource: [
            PriceData( 'FEB', coinPrice * 1.1),
            PriceData( 'MAR', coinPrice * 1.3),
            PriceData( 'APR', coinPrice * 1.2),
            PriceData( 'MAY', coinPrice * 1.5),
            PriceData( 'JUN', coinPrice * 1.3),
            PriceData( 'JUL', coinPrice * 1.2),
            PriceData( 'AUG', coinPrice * 1.6),
            PriceData( 'SEP', coinPrice * 2),
            PriceData( 'OCT', coinPrice * 1.8),
            PriceData( 'NOV', coinPrice * 1.5),
            PriceData( 'DEC', coinPrice * 1.8),
            PriceData( 'JAN', coinPrice * 1.3),
          ],
          trendlines:<Trendline>[
            Trendline( isVisible: false)
          ],
          xValueMapper: ( PriceData sales, _) => sales.month,
          yValueMapper: (PriceData sales, _) => sales.price,
          animationDuration: 1000,
        ),
      ],
    );
  }
}

class PriceData {
  PriceData( this.month, this.price);
  final String month;
  final double? price;
}