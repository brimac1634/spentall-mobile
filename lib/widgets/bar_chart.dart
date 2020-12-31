import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/bar_data.dart';

import '../app_theme.dart';

class BarChart extends StatelessWidget {
  final List<BarData> data;

  BarChart(this.data);

  List<charts.Series<BarData, String>> _setBarData(List<BarData> data) {
    return [
      charts.Series<BarData, String>(
        id: 'Time Data',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppTheme.pink),
        domainFn: (BarData bar, _) => bar.label,
        measureFn: (BarData bar, _) => bar.amount,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      _setBarData(data),
      animate: true,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
      ),
    );
  }
}
