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
    final _intervals = _getInterval(_maxAmount);
    return BarChart(BarChartData(
      gridData: FlGridData(
        show: true,
        horizontalInterval: _intervals,
        getDrawingHorizontalLine: (value) => FlLine(
          color: AppTheme.offWhite.withOpacity(_touchedIndex >= 0 ? 0.5 : 1),
          strokeWidth: 1,
        ),
      ),
      alignment: BarChartAlignment.spaceAround,
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          rotateAngle: 60,
          showTitles: true,
          getTextStyles: (value) {
            final _isSelected = value.toInt() == _touchedIndex;
            return TextStyle(
                color: AppTheme.offWhite,
                fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: _isSelected ? 16 : 12);
          },
          getTitles: (double value) {
            if (_touchedIndex != -1) {
              return _touchedIndex == value
                  ? widget.data[value.toInt()].label
                  : '';
            }
            if (widget.data.length > 20) {
              return value % 2 == 0 ? widget.data[value.toInt()].label : '';
            }
            return widget.data[value.toInt()].label;
          },
        ),
        leftTitles: SideTitles(
          interval: _intervals,
          showTitles: true,
          getTextStyles: (value) => TextStyle(
              color:
                  AppTheme.offWhite.withOpacity(_touchedIndex >= 0 ? 0.5 : 1),
              fontSize: 12),
        ),
      ),
      barGroups: dataIndexList.map((i) {
        final _show = _touchedIndex == -1 || _touchedIndex == i;
        final double _opacity = _show ? 1 : 0.3;
        return BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
                y: widget.data[i].amount,
                width: i == _touchedIndex ? 10 : 8,
                colors: [
                  AppTheme.lightPurple.withOpacity(_opacity),
                  AppTheme.pink.withOpacity(_opacity)
                ])
          ],
          showingTooltipIndicators: [0],
        );
      }).toList(),
      borderData: FlBorderData(
          // show: false,
          border: Border(
              left: BorderSide(
                  width: 1,
                  color: AppTheme.offWhite
                      .withOpacity(_touchedIndex >= 0 ? 0.5 : 1)),
              bottom: BorderSide(
                  width: 1,
                  color: AppTheme.offWhite
                      .withOpacity(_touchedIndex >= 0 ? 0.5 : 1)))),
      barTouchData: BarTouchData(
        enabled: true,
        touchCallback: (response) {
          setState(() {
            if (response.touchInput is FlLongPressEnd ||
                response.touchInput is FlPanEnd ||
                response.spot == null) {
              _touchedIndex = -1;
            } else {
              _touchedIndex = response.spot.touchedBarGroupIndex;
            }
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
                '${widget.currencySymbol}${rod.y.round().toString()}',
                TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              );
            }
            return null;
          },
        ),
      ),
    ));
  }
}
