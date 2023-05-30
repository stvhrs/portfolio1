// /// Package import
// import 'package:flutter/material.dart';
// import 'package:cahaya/models/history_saldo.dart';
// import 'package:cahaya/providerData/providerData.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// /// Chart import
// import 'package:syncfusion_flutter_charts/charts.dart';

// /// Local import
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// class LocalData extends StatefulWidget {
//   final List<HistorySaldo> histori;
//   LocalData(this.histori);

//   @override
//   _LocalDataState createState() => _LocalDataState();
// }

// class _LocalDataState extends State<LocalData> {
//   List<_ChartData>? chartData;
//   TrackballBehavior? _trackballBehavior;
//   @override
//   void initState() {
//     //print(widget.histori.length.toString() + 'histori');
//     super.initState();
//     _trackballBehavior = TrackballBehavior(
//         enable: true,
//         // lineColor: model.themeData.colorScheme.brightness == Brightness.dark
//         //     ? const Color.fromRGBO(255, 255, 255, 0.03)
//         //     : const Color.fromRGBO(0, 0, 0, 0.03),
//         lineWidth: 15,
//         activationMode: ActivationMode.singleTap,
//         markerSettings: const TrackballMarkerSettings(
//             borderWidth: 4,
//             height: 10,
//             width: 10,
//             markerVisibility: TrackballVisibilityMode.visible));
//     chartData = <_ChartData>[
//       ...widget.histori.where((element) => element==DateTime.parse(element.tanggalBerangkat).month ==
//                 DateTime.now().month &&
//             DateTime.parse(element.).year ==
//                 DateTime.now().year).map(
//         (e) => _ChartData(
//           x: DateTime.parse(e.tanggal),
//           y1: e.sisaSaldo,
//         ),
//       )
//       //     .toList()
//     ];
//     ;

//     // [
//     //   _ChartData(x: DateTime(2023, 11, 29-1), y1: 83,  ),

//     // ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildDefaultLineChart();
//   }

//   /// Get the cartesian chart with default line series
//   SfCartesianChart _buildDefaultLineChart() {
//     return SfCartesianChart(
//       plotAreaBorderWidth: 0,
//       title: ChartTitle(text: 'Grafik Saldo'),
//       legend:
//           Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//       primaryXAxis: DateTimeAxis(
//           edgeLabelPlacement: EdgeLabelPlacement.shift,
//           intervalType: DateTimeIntervalType.years,
//           dateFormat: DateFormat.m(),
//           name: 'Tanggal',
//           majorGridLines: const MajorGridLines(width: 0)),
//       primaryYAxis: NumericAxis(
//           minimum: 0,
//           maximum: Provider.of<ProviderData>(context, listen: false).totalSaldo,
//           interval: 5,
//           rangePadding: ChartRangePadding.none,
//           name: 'Nominal',
//           axisLine: const AxisLine(width: 0),
//           majorTickLines: const MajorTickLines(color: Colors.transparent)),
//       series: _getDefaultLineSeries(),
//       trackballBehavior: _trackballBehavior,
//     );
//   }

//   /// The method returns line series to chart.
//   List<LineSeries<_ChartData, DateTime>> _getDefaultLineSeries() {
//     return <LineSeries<_ChartData, DateTime>>[
//       LineSeries<_ChartData, DateTime>(
//           dataSource: chartData!,
//           xValueMapper: (_ChartData sales, _) => sales.x,
//           yValueMapper: (_ChartData sales, _) => sales.y1,
//           name: 'Saldo'),
//     ];
//   }

//   @override
//   void dispose() {
//     chartData!.clear();
//     super.dispose();
//   }
// }

// class _ChartData {
//   _ChartData({
//     this.x,
//     this.y1,
//   });
//   DateTime? x;
//   double? y1;
// }
