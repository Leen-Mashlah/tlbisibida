import 'dart:math' as math;
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// Assuming these imports are correct for your project
import 'package:lambda_dent_dash/components/tusk_icons.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

// Define a class for the dynamic input data structure
class ClientData {
  const ClientData({
    required this.name,
    required this.value,
    required this.shadowValue,
  });
  final String name;
  final double value;
  final double shadowValue;
}

class RevenuePerClientChart extends StatefulWidget {
  // Accept the list of dynamic client data
  RevenuePerClientChart({super.key, required this.clientRevenueData});

  // The list of dynamic data passed from the parent
  final List<ClientData> clientRevenueData;

  @override
  State<RevenuePerClientChart> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<RevenuePerClientChart> {
  // Define the predefined colors within the State class
  final List<Color> _mainColors = [
    Colors.indigo.shade700,
    Colors.deepPurple,
    Colors.purple,
    Colors.pinkAccent,
    redmain, // Using placeholder
    Colors.deepOrange.shade700,
    Colors.red.shade800,
    const Color.fromARGB(255, 188, 115, 88),
    cyan400, // Using placeholder
    cyan500, // Using placeholder
  ];

  final List<Color> _secondaryColors = [
    Colors.indigo.shade200,
    Colors.deepPurple.shade100,
    Colors.purple.shade100,
    Colors.pinkAccent.shade100,
    redbackground, // Using placeholder
    Colors.deepOrange.shade100,
    Colors.red.shade100,
    const Color.fromARGB(255, 255, 221, 209),
    cyan200, // Using placeholder
    cyan300, // Using placeholder
  ];

  // State variable to hold the processed _BarData list with colors assigned
  late List<_BarData> _barDataList;

  @override
  void initState() {
    super.initState();
    // Process the dynamic data and assign colors when the widget is created
    _barDataList = _processClientData(widget.clientRevenueData);
  }

  @override
  void didUpdateWidget(covariant RevenuePerClientChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the input data changes, re-process it and update the state
    if (oldWidget.clientRevenueData != widget.clientRevenueData) {
      _barDataList = _processClientData(widget.clientRevenueData);
    }
  }

  // Method to map dynamic data to _BarData with assigned colors from the predefined lists
  List<_BarData> _processClientData(List<ClientData> dynamicData) {
    return dynamicData.asMap().entries.map((e) {
      final index = e.key;
      final data = e.value;
      // Assign colors cyclically based on the index of the data point
      final colorIndex = index % _mainColors.length;
      return _BarData(
        data.name,
        _mainColors[colorIndex],
        _secondaryColors[colorIndex],
        data.value,
        data.shadowValue,
      );
    }).toList();
  }

  String _formatYValue(double value) {
    if (value.abs() >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(value.abs() % 1000000 == 0 ? 0 : 1)} مليون';
    } else if (value.abs() >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)} ألف';
    }
    return value.toStringAsFixed(0);
  }

  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    Color secondary,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: secondary,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  int maxval() {
    int max = 0;
    for (var element in widget.clientRevenueData) {
      element.value > max ? max = element.value.toInt() : max = max;
      element.shadowValue > max ? max = element.shadowValue.toInt() : max = max;
    }

    for (var i = 0; i < 100; i++) {
      if (max % 100 != 0) {
        max--;
      }
    }
    print(max);
    print('max val = $max');
    return max + findLargestPowerOf10(max);
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

  @override
  Widget build(BuildContext context) {
    // Find the maximum value in the processed _barDataList to set maxY dynamically
    int maxY = 0;
    // for (var data in _barDataList) {
    //   if (data.value > maxY) {
    //     maxY = data.value;
    //   }
    //   if (data.shadowValue > maxY) {
    //     maxY = data.shadowValue;
    //   }
    // }
    // // Add some padding to the maxY for better visualization
    maxY = maxval();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // const Text(
          //   'أكثر 10 زبائن مردوداً', // Title remains static
          //   style: TextStyle(
          //     color: cyan500,
          //     fontSize: 20,
          //   ),
          // ),
          // const SizedBox(height: 18),
          RotatedBox(
            quarterTurns: 1,
            child: AspectRatio(
              aspectRatio: .9,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.symmetric(
                      horizontal: BorderSide(color: cyan_navbar_600),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        interval: findLargestPowerOf10(maxY) * 1.0,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                            space: 20,
                            angle: -pi / 2,
                            child: Text(
                              textAlign: TextAlign.center,
                              _formatYValue(value),
                              style: TextStyle(color: cyan500, fontSize: 12),
                            ),
                            axisSide: AxisSide.left),
                        showTitles: true,
                        reservedSize: 50,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 150,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          // Ensure the index is within the bounds of the processed data list
                          if (index < 0 || index >= _barDataList.length) {
                            return Container(); // Return empty container if index is out of bounds
                          }
                          return RotatedBox(
                            quarterTurns: -1,
                            child: SideTitleWidget(
                                axisSide: AxisSide.top,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _barDataList[index].name,
                                      style: TextStyle(
                                        color: _barDataList[index].color,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    _IconWidget(
                                      color: _barDataList[index].color,
                                      isSelected: touchedGroupIndex == index,
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: cyan_navbar_600,
                      strokeWidth: 1,
                    ),
                  ),
                  // Use the processed _barDataList to generate bar groups
                  barGroups: _barDataList.asMap().entries.map((e) {
                    final index = e.key;
                    final data = e.value;
                    return generateBarGroup(
                      index,
                      data.color,
                      data.secondary,
                      data.value,
                      data.shadowValue,
                    );
                  }).toList(),
                  // Use the dynamic maxY
                  maxY: maxY * 1.0,
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Colors.transparent,
                      tooltipMargin: 0,
                      fitInsideVertically: true,
                      fitInsideHorizontally: true,
                      rotateAngle: -90,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.toY.toString(),
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: rod.color,
                            fontSize: 18,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 12,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// _BarData class remains the same structure
class _BarData {
  const _BarData(
      this.name, this.color, this.secondary, this.value, this.shadowValue);
  final String name;
  final Color secondary;
  final Color color;
  final double value;
  final double shadowValue;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.2;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(12, 12),
      child: Icon(
        TuskIcons.dentist,
        color: widget.color,
        size: 24,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}
