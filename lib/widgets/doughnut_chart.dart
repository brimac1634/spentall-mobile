import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/category_percent.dart';

import '../app_theme.dart';
import '../helpers/extensions.dart';

class DoughnutChart extends StatelessWidget {
  final int arcWidth;
  final List<CategoryPercent> categories;

  DoughnutChart(this.categories, {this.arcWidth = 100});

  List<charts.Series<CategoryPercent, int>> _setCategoryData(
      List<CategoryPercent> data) {
    return [
      charts.Series<CategoryPercent, int>(
        id: 'Categories',
        domainFn: (CategoryPercent item, i) => i,
        measureFn: (CategoryPercent item, _) => (item.percent * 100).floor(),
        data: data,
        colorFn: (_, index) => index % 2 == 0
            ? charts.ColorUtil.fromDartColor(AppTheme.lightPurple)
            : charts.ColorUtil.fromDartColor(AppTheme.pink),
        // insideLabelStyleAccessorFn: (_, __) => charts.TextStyleSpec(
        //     fontSize: 16,
        //     color: charts.ColorUtil.fromDartColor(AppTheme.offWhite),
        //     fontWeight: '500'),
        labelAccessorFn: (CategoryPercent item, _) =>
            item.category.capitalize(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      _setCategoryData(categories),
      animate: true,
      animationDuration: Duration(milliseconds: 600),
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: arcWidth,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
              showLeaderLines: false,
              // leaderLineColor: charts.MaterialPalette.deepOrange.shadeDefault,
              outsideLabelStyleSpec: charts.TextStyleSpec(
                  fontSize: 14,
                  color: charts.ColorUtil.fromDartColor(AppTheme.offWhite),
                  fontWeight: '500',
                  fontFamily: AppTheme.fontName),
              insideLabelStyleSpec: charts.TextStyleSpec(
                  fontSize: 14,
                  color: charts.ColorUtil.fromDartColor(AppTheme.offWhite),
                  fontWeight: '500',
                  fontFamily: AppTheme.fontName),
              labelPosition: charts.ArcLabelPosition.auto)
        ],
      ),
      selectionModels: [
        charts.SelectionModelConfig(changedListener: (selectionModel) {
          final selectedData = selectionModel.selectedDatum;

          if (selectedData.isNotEmpty) {
            final category = selectedData.first.datum.category;
            print(category);
          }
        }),
      ],
    );
  }
}
