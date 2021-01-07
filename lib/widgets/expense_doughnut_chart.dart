import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import '../models/category_percent.dart';

import '../app_theme.dart';
import '../helpers/extensions.dart';
import '../helpers/utils.dart' as utils;

class ExpenseDoughnutChart extends StatefulWidget {
  final double width;
  final String currencySymbol;
  final List<CategoryPercent> categories;

  ExpenseDoughnutChart(this.categories,
      {this.width = 100, this.currencySymbol = '\$'});

  @override
  _ExpenseDoughnutChartState createState() => _ExpenseDoughnutChartState();
}

class _ExpenseDoughnutChartState extends State<ExpenseDoughnutChart> {
  final List<Color> _colors = [
    AppTheme.lightPurple,
    AppTheme.lightBlue,
    AppTheme.offWhite,
    AppTheme.pink,
    AppTheme.darkerPurple
  ];
  int _touchedIndex = -1;

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.categories.length, (i) {
      final _isTouched = i == _touchedIndex;
      final double _fontSize = _isTouched ? 25 : 16;
      final double _radius =
          _isTouched ? widget.width * 0.33 : widget.width * 0.28;
      final _category = widget.categories[i];
      final _color = _colors[i % _colors.length]
          .darken(percent: (i / _colors.length).floor() * 10);
      return PieChartSectionData(
        color: _isTouched ? _color : _color.withAlpha(180),
        value: _category.percent,
        title: '${(_category.percent * 100).round()}%',
        radius: _radius,
        titleStyle: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.bold,
            color: _color.computeLuminance() < 0.4
                ? AppTheme.offWhite
                : AppTheme.darkerPurple),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PieChart(
        PieChartData(
            pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
              setState(() {
                if (pieTouchResponse.touchInput is FlLongPressEnd ||
                    pieTouchResponse.touchInput is FlPanEnd) {
                  _touchedIndex = -1;
                } else {
                  _touchedIndex = pieTouchResponse.touchedSectionIndex;
                }
              });
            }),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: widget.width * 0.15,
            sections: showingSections()),
      ),
      SizedBox(
        height: 22,
      ),
      ...List.generate(
        widget.categories.length,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: (_touchedIndex == -1 || i == _touchedIndex) ? 1 : 0.5,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: _colors[i % _colors.length]
                        .darken(percent: (i / _colors.length).floor() * 10),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.categories[i].category.capitalize(),
                    style: AppTheme.label2,
                    textAlign: TextAlign.left,
                  ),
                  Spacer(),
                  Text(
                    '${widget.currencySymbol ?? '\$'}${utils.formatAmount(widget.categories[i].total)}',
                    style: AppTheme.label2,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    ' (${(widget.categories[i].percent * 100).round()}%)',
                    style: AppTheme.label2,
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
