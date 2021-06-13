import 'package:crypto_tracker/common/appColors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyChartWidget extends StatefulWidget {
  List<dynamic> data;
  String coin;
  // ignore: prefer_const_constructors_in_immutables
  MyChartWidget({
    Key? key,
    required this.data,
    required this.coin,
  }) : super(key: key);

  @override
  MyChartWidgetState createState() => MyChartWidgetState();
}

class MyChartWidgetState extends State<MyChartWidget> {

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(color: Color(0xffaab1bf)),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(color: Color(0xffaab1bf)),
      ),
      // Chart title
      title: ChartTitle(
          text: widget.coin.toUpperCase(),
          textStyle: TextStyle(color: Colors.blue[300], fontSize: 24)),
      // Enable legend
      legend: Legend(isVisible: true),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      zoomPanBehavior: ZoomPanBehavior(
          zoomMode: ZoomMode.xy, enablePanning: true, enablePinching: true),
      series: <ChartSeries<dynamic, String>>[
        LineSeries<dynamic, String>(
          dataSource: widget.data,
          xValueMapper: (dynamic sales, _) {
            DateTime date = DateTime.fromMillisecondsSinceEpoch(sales["time"]);
            return "${date.day}/${date.month}/${date.year}";
          },
          yValueMapper: (dynamic sales, _) => double.parse(sales["priceUsd"]),
          name: widget.coin.toUpperCase(),
          color: Colors.blue[300],
          enableTooltip: true,
          isVisibleInLegend: false,
        )
      ],
    );
  }
}
