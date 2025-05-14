import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:lambda_dent_dash/constants/constants.dart';

class MonthlyFinancialData {
  final int id;
  final String month;
  final double revenue;
  final double expenses;

  MonthlyFinancialData({
    required this.id,
    required this.month,
    required this.revenue,
    required this.expenses,
  });

  double get profitOrLoss => revenue - expenses;
}

class MonthlyFinancialChart extends StatelessWidget {
  List<MonthlyFinancialData> chartData;

  final double _mainBarWidth = 30.0;
  final double _rodBorderRadius = 8;
  double _minY = -10000000;
  double _maxY = 10000000;
  double _yAxisInterval = 1000;

  final Color _revenueColor = cyan500;
  final Color _expensesColor = Colors.red.shade800;
  final Color _profitColor = cyan300;
  final Color _lossColor = Colors.red.shade200;
  final Color _gridColor = cyan400;
  final Color _borderColor = cyan400;
  final Color _axisTextColor = cyan600;

  MonthlyFinancialChart({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    int max = maxval(chartData);
    _yAxisInterval = findLargestPowerOf10(max) * 1.0;
    max += findLargestPowerOf10(max);
    _maxY = max * 1.0;
    _minY = -max * 1.0;
    print('interval = ' + _yAxisInterval.toString());
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BarChart(
          BarChartData(
            minY: _minY,
            maxY: _maxY,
            groupsSpace: 40,
            alignment: BarChartAlignment.center,
            titlesData: FlTitlesData(
              show: true,
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: _bottomTitles,
                  interval: 1,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 55,
                  getTitlesWidget: _leftTitles,
                  interval: _yAxisInterval,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: _yAxisInterval,
              getDrawingHorizontalLine: (value) => FlLine(
                color: value == 0 ? cyan500 : _gridColor,
                strokeWidth: value == 0 ? .5 : 0.6,
                dashArray: value == 0 ? null : [4, 4],
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(color: _borderColor, width: .5),
                bottom: BorderSide(color: _borderColor, width: .5),
              ),
            ),
            barGroups: chartData
                .map((data) => _generateStackedBarGroup(data))
                .toList(),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (group) => cyan50op,
                // tooltipBgColor: Colors.black87,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final data = chartData[group.x];
                  return BarTooltipItem('${data.month}\n',
                      const TextStyle(color: cyan600, fontSize: 12),
                      children: [
                        TextSpan(
                          text: 'الوارد: ' +
                              data.revenue.toInt().toString() +
                              '\n',
                          style: TextStyle(color: _revenueColor),
                        ),
                        TextSpan(
                          text: 'المدفوعات: ' +
                              data.expenses.toInt().toString() +
                              '\n',
                          style: TextStyle(color: _expensesColor),
                        ),
                        TextSpan(
                          text: data.profitOrLoss > 0
                              ? 'الربح: ' + data.profitOrLoss.toInt().toString()
                              : data.profitOrLoss < 0
                                  ? 'الخسارة: ' +
                                      data.profitOrLoss.toInt().toString()
                                  : 'تعادل',
                          style: TextStyle(
                            color: data.profitOrLoss >= 0
                                ? _profitColor
                                : _lossColor,
                          ),
                        )
                      ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _generateStackedBarGroup(MonthlyFinancialData data) {
    final double revenue = data.revenue;
    final double expenses = data.expenses;
    final double profitOrLoss = data.profitOrLoss;

    List<BarChartRodStackItem> stackItems = [];

    if (revenue > 0) {
      stackItems.add(BarChartRodStackItem(
        0,
        revenue,
        _revenueColor,
      ));
    }
    if (expenses > 0) {
      stackItems.add(BarChartRodStackItem(
        -expenses,
        0,
        _expensesColor,
      ));
    }

    if (profitOrLoss > 0) {
      stackItems.add(BarChartRodStackItem(
        0,
        profitOrLoss,
        _profitColor,
      ));
    } else if (profitOrLoss < 0) {
      stackItems.add(BarChartRodStackItem(
        profitOrLoss,
        0,
        _lossColor,
      ));
    }

    return BarChartGroupData(
      x: data.id,
      barRods: [
        BarChartRodData(
          borderSide: BorderSide(
            width: 4,
            color: const Color.fromARGB(73, 211, 241, 238),
          ),
          toY: math.max(revenue, profitOrLoss),
          fromY: math.min(-expenses, profitOrLoss),
          width: _mainBarWidth,
          borderRadius: BorderRadius.circular(_rodBorderRadius),
          rodStackItems: stackItems,
        ),
      ],
    );
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    final int index = value.toInt();
    String text = '';
    if (index >= 0 && index < chartData.length) {
      text = chartData[index].month;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10.0,
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: _axisTextColor,
              fontSize: 12,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    if (value % _yAxisInterval != 0 && value != 0) {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10.0,
      child: Text(
        _formatYValue(value),
        style: TextStyle(color: _axisTextColor, fontSize: 11),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _formatYValue(double value) {
    if (value.abs() >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(value.abs() % 1000000 == 0 ? 0 : 1)} مليون';
    } else if (value.abs() >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)} ألف';
    }
    return value.toStringAsFixed(0);
  }
}

int maxval(List<MonthlyFinancialData> data) {
  int max = 0;
  for (var element in data) {
    element.expenses > max ? max = element.expenses.toInt() : max = max;
    element.revenue > max ? max = element.revenue.toInt() : max = max;
  }

  for (var i = 0; i < 100; i++) {
    if (max % 100 != 0) {
      max--;
    }
  }
  print(max);
  print('max val = $max');
  return max;
}

int findLargestPowerOf10(int number) {
  if (number < 0) {
    throw ArgumentError('Input must be a non-negative number.');
  }

  if (number == 0) {
    return 1;
  }

  int result = 1;

  while (result * 10 <= number) {
    result *= 10;
  }

  return result;
}
