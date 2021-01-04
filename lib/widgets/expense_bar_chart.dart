import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/bar_data.dart';

import '../app_theme.dart';

class ExpenseBarChart extends StatefulWidget {
  final List<BarData> data;
  final String currencySymbol;

  ExpenseBarChart(this.data, this.currencySymbol);

  @override
  _ExpenseBarChartState createState() => _ExpenseBarChartState();
}

class _ExpenseBarChartState extends State<ExpenseBarChart> {
  int _touchedIndex = -1;

  double _getInterval(double max) {
    if (max <= 2) {
      return 0.5;
    } else if (max <= 10) {
      return 1;
    } else if (max <= 100) {
      return 10;
    } else if (max <= 1000) {
      return 100;
    } else if (max <= 10000) {
      return 1000;
    } else if (max <= 100000) {
      return 10000;
    }
    return (max / 10).round().toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final dataIndexList = Iterable<int>.generate(widget.data.length).toList();

    final _maxAmount = widget.data.fold<double>(0, (accum, item) {
      if (item.amount > accum) {
        accum = item.amount;
      }
      return accum;
    });
    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          rotateAngle: 60,
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: AppTheme.offWhite,
              // fontWeight: FontWeight.bold,
              fontSize: 12),
          // margin: 20,
          getTitles: (double value) {
            if (widget.data.length > 20) {
              return value % 2 == 0 ? widget.data[value.toInt()].label : '';
            }
            return widget.data[value.toInt()].label;
          },
        ),
        leftTitles: SideTitles(
          interval: _getInterval(_maxAmount),
          showTitles: true,
          getTextStyles: (value) =>
              const TextStyle(color: AppTheme.offWhite, fontSize: 12),
        ),
      ),
      barGroups: dataIndexList
          .map(
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                    y: widget.data[i].amount,
                    colors: [AppTheme.lightPurple, AppTheme.pink])
              ],
              showingTooltipIndicators: [0],
            ),
          )
          .toList(),
      borderData: FlBorderData(
          // show: false,
          border: Border(
              left: BorderSide(width: 1, color: AppTheme.offWhite),
              bottom: BorderSide(width: 1, color: AppTheme.offWhite))),
      barTouchData: BarTouchData(
        enabled: true,
        touchCallback: (response) {
          if (response.spot == null) {
            setState(() {
              _touchedIndex = -1;
            });
            return;
          }
          final index = response.spot.touchedBarGroupIndex;
          setState(() {
            _touchedIndex = index;
          });
        },
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipBottomMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            if (groupIndex == _touchedIndex) {
              return BarTooltipItem(
                '${widget.data[groupIndex].label}: ${widget.currencySymbol}${rod.y.round().toString()}',
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }
            return null;
          },
        ),
      ),
    ));
  }
}
