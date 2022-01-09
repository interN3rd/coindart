import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceChart extends StatefulWidget {

  final String coinSymbol;
  final double coinPrice;

  String get symbol => coinSymbol;
  double get price => coinPrice;

  const PriceChart(this.coinSymbol, this.coinPrice, {Key? key}) : super(key: key);


  @override
  _PriceChartState createState() => _PriceChartState();

}

class _PriceChartState extends State<PriceChart> {

  late List<ChartData> _chartData;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
      enable: true, activationMode: ActivationMode.singleTap
    );
    super.initState();
  }
  @override
  Widget build( BuildContext context ) {
    return SfCartesianChart(
      title: ChartTitle( text: widget.symbol + "/USD price history",
      textStyle: const TextStyle(
        color: Colors.white,
      ),
      backgroundColor: Colors.deepPurple),
      trackballBehavior: _trackballBehavior,
      series: <CandleSeries>[
        CandleSeries<ChartData, DateTime>(
          dataSource: _chartData,
          xValueMapper: (ChartData priceData, _) => priceData.x,
          lowValueMapper: (ChartData priceData, _) => priceData.low,
          highValueMapper: (ChartData priceData, _) => priceData.high,
          openValueMapper: (ChartData priceData, _) => priceData.open,
          closeValueMapper: (ChartData priceData, _) => priceData.close,
        ),
      ],
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.MMMd(),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)
      )
    );
  }

  // static data was created, because historic price data is not available in the
  // basic CoinMarketCap API pricing plan
  List<ChartData> getChartData() {
    return <ChartData> [
      ChartData( x: DateTime( 2021, 12, 23) ),
      ChartData(
          x: DateTime( 2021, 12, 24),
          open: widget.price,
          high: widget.price * 1.99,
          low: widget.price,
          close: widget.price * 1.99
      ),
      ChartData(
          x: DateTime( 2021, 12, 25),
          open: widget.price * 1.99,
          high: widget.price * 1.99,
          low: widget.price * 1.9,
          close: widget.price * 1.99
      ),
      ChartData(
          x: DateTime( 2021, 12, 26),
          open: widget.price * 1.99,
          high: widget.price * 1.99,
          low: widget.price * 1.5,
          close: widget.price * 1.99
      ),
      ChartData(
          x: DateTime( 2021, 12, 27),
          open: widget.price * 1.99,
          high: widget.price * 1.99,
          low: widget.price * 1.5,
          close: widget.price * 1.5
      ),
      ChartData(
          x: DateTime( 2021, 12, 28),
          open: widget.price * 1.5,
          high: widget.price * 1.5,
          low: widget.price * 0.6,
          close: widget.price * 0.7
      ),
      ChartData(
          x: DateTime( 2021, 12, 29),
          open: widget.price * 0.7,
          high: widget.price * 1.05,
          low: widget.price * 0.7,
          close: widget.price
      ),
      ChartData(
        x: DateTime( 2021, 12, 30),
        open: widget.price,
        high: widget.price * 1.03,
        low: widget.price * 0.92,
        close: widget.price * 0.98
      ),
      ChartData(
          x: DateTime( 2021, 12, 31),
          open: widget.price * 0.90,
          high: widget.price * 1.1,
          low: widget.price * 0.8,
          close: widget.price * 1.05),
      ChartData(
          x: DateTime( 2022, 01, 01),
          open: widget.price * 1.05,
          high: widget.price * 1.1,
          low: widget.price * 1.05,
          close: widget.price * 1.1),
      ChartData(
          x: DateTime( 2022, 01, 02),
          open: widget.price * 1.1,
          high: widget.price * 1.3,
          low: widget.price * 1.1,
          close: widget.price * 1.18),
      ChartData(
          x: DateTime( 2022, 01, 03),
          open: widget.price * 1.18,
          high: widget.price * 1.2,
          low: widget.price * 1.15,
          close: widget.price * 1.18),
      ChartData(
          x: DateTime( 2022, 01, 04),
          open: widget.price * 1.18,
          high: widget.price * 1.4,
          low: widget.price * 1.18,
          close: widget.price * 1.26),
      ChartData(
          x: DateTime( 2022, 01, 05),
          open: widget.price * 1.26,
          high: widget.price * 1.26,
          low: widget.price * 1.0,
          close: widget.price * 1.02),
      ChartData(
          x: DateTime( 2022, 01, 06),
          open: widget.price * 1.02,
          high: widget.price * 1.02,
          low: widget.price * 0.9,
          close: widget.price * 0.9),
      ChartData(
          x: DateTime( 2022, 01, 07),
          open: widget.price * 0.9,
          high: widget.price * 1.3,
          low: widget.price * 0.85,
          close: widget.price * 1.3),
      ChartData(
          x: DateTime( 2022, 01, 08),
          open: widget.price * 1.3,
          high: widget.price * 1.7,
          low: widget.price * 1.3,
          close: widget.price * 1.4),
      ChartData(
          x: DateTime( 2022, 01, 09 ) ),
    ];
  }
}

class ChartData {

  ChartData( { this.x, this.open, this.close, this.low, this.high } );

  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;

}