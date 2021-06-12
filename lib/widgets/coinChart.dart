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
  // List<Map<String, dynamic>> data = [
  //   {"priceUsd": "6379.3997635993342453", "time": 15304032},
  //   {"priceUsd": "6466.3135622762295280", "time": 15304896},
  //   {"priceUsd": "6601.0724971279524219", "time": 15305760},
  //   {"priceUsd": "6581.0092630267574887", "time": 15306624},
  //   {"priceUsd": "6629.1362927171773870", "time": 15307488},
  //   {"priceUsd": "6549.1112450806328349", "time": 15308352},
  //   {"priceUsd": "6655.9108972488685303", "time": 15309216},
  //   {"priceUsd": "6818.2081672225807333", "time": 15310080},
  //   {"priceUsd": "6741.7764822044089258", "time": 15310944},
  //   {"priceUsd": "6525.5093638185088059", "time": 15311808},
  //   {"priceUsd": "6585.4814995139912926", "time": 15312672},
  //   {"priceUsd": "6489.0484273708415619", "time": 15313536},
  //   {"priceUsd": "6291.0146998844553630", "time": 15314400},
  //   {"priceUsd": "6252.1208882488125434", "time": 15315264},
  //   {"priceUsd": "6340.1868649492544957", "time": 15316128},
  //   {"priceUsd": "6530.5736788831891429", "time": 15316992},
  //   {"priceUsd": "6884.5482398003929297", "time": 15317856},
  //   {"priceUsd": "7409.9979715905945494", "time": 15318720},
  //   {"priceUsd": "7395.3701986813659323", "time": 15319584},
  //   {"priceUsd": "7425.9746148291378074", "time": 15320448},
  //   {"priceUsd": "7346.6049106335193051", "time": 15321312},
  //   {"priceUsd": "7446.3683595137795620", "time": 15322176},
  //   {"priceUsd": "7672.2795468901929951", "time": 15323040},
  //   {"priceUsd": "8058.3217339088221456", "time": 15323904},
  //   {"priceUsd": "8232.6844834113199475", "time": 15324768},
  //   {"priceUsd": "8171.3690575620503343", "time": 15325632},
  //   {"priceUsd": "8004.3080625949240423", "time": 15326496},
  //   {"priceUsd": "8158.6671323110608870", "time": 15327360},
  //   {"priceUsd": "8183.3394012885138213", "time": 15328224},
  //   {"priceUsd": "8121.8084601148850521", "time": 15329088},
  //   {"priceUsd": "7907.5242567350601721", "time": 15329952},
  //   {"priceUsd": "7581.6106106966728131", "time": 15331680},
  //   {"priceUsd": "7389.6890782016167515", "time": 15332544},
  //   {"priceUsd": "7247.2622645760407444", "time": 15333408},
  //   {"priceUsd": "6987.2119251945676799", "time": 15334272}
  // ];

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
