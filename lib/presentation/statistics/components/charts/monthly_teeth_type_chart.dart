import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'dart:developer'
    as developer; // Use developer.log for potentially better visibility
import 'dart:math' as math; // Import for ceiling function

// Assuming constants.dart contains your color definitions

// Define the color ranges for the dynamic lines
final List<Color> cyanColorRange = [
  const Color.fromARGB(255, 181, 63, 163),
  cyan400,
  const Color.fromARGB(255, 149, 132, 0),
  const Color.fromARGB(255, 36, 161, 210),
];

final List<Color> pinkColorRange = [
  const Color.fromARGB(255, 255, 169, 155),
  const Color.fromARGB(255, 71, 71, 153),
  const Color.fromARGB(255, 201, 118, 114),
];

// Combine the color ranges for dynamic line coloring
final List<Color> allLineColors = [...cyanColorRange, ...pinkColorRange];

// New data model for treatment data
class TreatmentData {
  final String name;
  // List of values for each month for this treatment type
  final List<double> values;

  TreatmentData({required this.name, required this.values});

  // Added equality check for didUpdateWidget
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TreatmentData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          listEquals(
              values, other.values); // Using listEquals for list comparison

  @override
  int get hashCode => name.hashCode ^ values.hashCode;
}

// This widget displays the monthly session type chart with dynamic TreatmentData input
class DynamicMonthlyChart extends StatefulWidget {
  const DynamicMonthlyChart({
    super.key,
    required this.data, // Accepts a list of TreatmentData
    required this.monthLabels, // Accepts a list of month labels
  });

  final List<TreatmentData> data;
  final List<String> monthLabels;

  @override
  State<DynamicMonthlyChart> createState() => _DynamicMonthlyChartState();
}

class _DynamicMonthlyChartState extends State<DynamicMonthlyChart> {
  // List of lists to hold FlSpot data for each dynamic line (treatment)
  List<List<FlSpot>> _dynamicSpots = [];
  List<String> _monthLabels = [];
  // Set to hold the x-axis indices of months where tooltips are currently showing
  Set<int> _showingTooltipOnMonths = {};
  // List to hold the names of each line (treatment names)
  List<String> _lineNames = [];

  // State variables for dynamic Y-axis range and interval
  double _maxY = 10.0; // Default minimum maxY
  double _yInterval = 1.0; // Default yInterval

  @override
  void initState() {
    super.initState();
    _processData(widget.data, widget.monthLabels);
  }

  @override
  void didUpdateWidget(covariant DynamicMonthlyChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the data or month labels have changed
    if (oldWidget.data != widget.data ||
        oldWidget.monthLabels != widget.monthLabels) {
      _processData(widget.data, widget.monthLabels);
      _showingTooltipOnMonths = {}; // Reset tooltips when data changes
    }
  }

  // Processes the input List<TreatmentData> and month labels to create dynamic FlSpot lists and line names
  void _processData(List<TreatmentData> data, List<String> monthLabels) {
    _dynamicSpots = [];
    _monthLabels = monthLabels; // Set month labels directly
    _lineNames = []; // Reset line names list

    int maxLines =
        data.length; // Number of lines is the number of treatment types
    int maxMonths =
        monthLabels.length; // Number of months is the length of month labels

    if (maxLines > 0) {
      // Initialize the list of spot lists and line names lists
      _dynamicSpots = List.generate(maxLines, (_) => []);
      _lineNames = List.generate(maxLines, (_) => '');
    }

    double currentMaxY = 0.0;
    for (int lineIndex = 0; lineIndex < maxLines; lineIndex++) {
      final treatmentData = data[lineIndex];
      _lineNames[lineIndex] = treatmentData.name; // Set the name for this line

      // Populate the dynamic spot list for this line
      for (int monthIndex = 0; monthIndex < maxMonths; monthIndex++) {
        double patientValue = 0.0;
        // If a value exists for this month for this treatment type, add the spot
        if (monthIndex < treatmentData.values.length) {
          patientValue = treatmentData.values[monthIndex];
        }
        // Add the spot (with value 0.0 if missing)
        _dynamicSpots[lineIndex]
            .add(FlSpot(monthIndex.toDouble(), patientValue));

        if (patientValue > currentMaxY) {
          currentMaxY = patientValue;
        }
      }
    }

    // Calculate dynamic maxY and yInterval
    _calculateYAxis(currentMaxY);

    // Request a new frame to ensure the chart updates after data processing
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  // Calculates the appropriate maxY and yInterval based on the maximum data value
  void _calculateYAxis(double currentMaxY) {
    if (currentMaxY <= 0) {
      _maxY = 10.0;
      _yInterval = 1.0;
      return;
    }

    // Add some padding to the max Y value
    double paddedMaxY = currentMaxY * 1.2;

    // Determine a suitable interval
    double interval = 1.0;
    while (paddedMaxY / interval > 10) {
      // Aim for roughly 5-10 intervals
      if (interval == 1 || interval == 2 || interval == 5) {
        interval *= 2;
      } else {
        interval *= 5;
      }
    }
    // Ensure interval is not 0 if paddedMaxY is very small
    if (interval == 0) interval = 1.0;

    _yInterval = interval;
    // Round maxY up to the nearest interval
    _maxY = (paddedMaxY / _yInterval).ceil() * _yInterval;
    // Ensure maxY is at least the original max value if rounding down occurred
    if (_maxY < currentMaxY) {
      _maxY = (currentMaxY / _yInterval).ceil() * _yInterval;
    }
    // Ensure a minimum maxY
    if (_maxY < 10) _maxY = 10;
    // Ensure a minimum interval
    if (_yInterval < 1) _yInterval = 1;

    developer.log('Calculated maxY: $_maxY, yInterval: $_yInterval',
        name: 'DynamicMonthlyChart'); // Debug log
  }

  // Determine the maximum X value needed for the chart
  double _getMaxX() {
    // Max X is the index of the last month plus some padding
    return (_monthLabels.length > 0 ? _monthLabels.length - 1 : 0).toDouble() +
        1;
  }

  // Configuration for touch interaction and tooltips
  LineTouchData get lineTouchData => LineTouchData(
        enabled: true, // Enable touch interaction
        handleBuiltInTouches:
            false, // Handle touches manually for click behavior
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          developer.log('Touch event: $event, Response: $response',
              name: 'DynamicMonthlyChart'); // Debug log

          if (response == null || response.lineBarSpots == null) {
            return;
          }
          // Toggle tooltip visibility for the entire month on tap
          if (event is FlTapUpEvent) {
            final clickedSpot = response.lineBarSpots!.first;
            final monthIndex =
                clickedSpot.x.toInt(); // Get the month index (x-value)

            developer.log(
                'Tapped on month index: $monthIndex. Current showingTooltipOnMonths: $_showingTooltipOnMonths',
                name: 'DynamicMonthlyChart'); // Debug log

            setState(() {
              // If the clicked month is already showing tooltips, remove it.
              // Otherwise, clear the set and add the clicked month.
              if (_showingTooltipOnMonths.contains(monthIndex)) {
                _showingTooltipOnMonths.remove(monthIndex);
              } else {
                _showingTooltipOnMonths.clear(); // Clear previous months
                _showingTooltipOnMonths.add(monthIndex); // Add the new month
              }
              developer.log(
                  'Updated showingTooltipOnMonths: $_showingTooltipOnMonths',
                  name: 'DynamicMonthlyChart'); // Debug log after update
            });
          }
        },
        mouseCursorResolver: (FlTouchEvent event, LineTouchResponse? response) {
          if (response == null || response.lineBarSpots == null) {
            return SystemMouseCursors.basic;
          }
          return SystemMouseCursors.click; // Show click cursor on hover
        },
        // Removed the indicator to fix tooltip visibility
        // Configure the tooltip appearance and content (shown for clicked spots)
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => const Color.fromARGB(
              120, 176, 190, 197), // Tooltip background color
          tooltipRoundedRadius: 8, // Rounded corners for tooltip
          tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 4), // Padding inside tooltip
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            developer.log('getTooltipItems called with: $lineBarsSpot',
                name: 'DynamicMonthlyChart'); // Debug log
            return lineBarsSpot.map((lineBarSpot) {
              // Get the treatment name for this line
              String treatmentName = '';
              final lineIndex = lineBarSpot.barIndex;
              if (lineIndex < _lineNames.length) {
                treatmentName = _lineNames[lineIndex];
              }

              // Display the treatment name and count in the tooltip with the line's color
              return LineTooltipItem(
                '$treatmentName: ${lineBarSpot.y.toInt()}', // Display name and value
                TextStyle(
                  // Use TextStyle to set color
                  color: lineBarSpot
                      .bar.color, // Set text color to the line's color
                  fontWeight: FontWeight.bold,
                  fontSize: 12, // Smaller font size for labels
                ),
              );
            }).toList();
          },
        ),
      );

  // Configuration for axis titles and labels (adapted from original)
  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles, // Bottom axis titles (months)
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Hide right axis titles
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Hide top axis titles
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(), // Left axis titles (patient counts)
        ),
      );

  // Data for the lines using dynamic data and original styles
  List<LineChartBarData> get lineBarsData {
    developer.log(
        'lineBarsData getter called. Showing tooltips for months: $_showingTooltipOnMonths',
        name: 'DynamicMonthlyChart'); // Debug log

    List<LineChartBarData> bars = [];
    for (int i = 0; i < _dynamicSpots.length; i++) {
      // Get a unique color for this line from the combined color list
      Color lineColor = allLineColors[i % allLineColors.length];

      // Determine if this line has consecutive 0s to adjust curve smoothness
      bool hasConsecutiveZeros = false;
      for (int j = 0; j < _dynamicSpots[i].length - 1; j++) {
        if (_dynamicSpots[i][j].y == 0.0 && _dynamicSpots[i][j + 1].y == 0.0) {
          hasConsecutiveZeros = true;
          break;
        }
      }

      bars.add(LineChartBarData(
        // showingIndicators is not used when showingTooltipIndicators is set in LineChartData
        isCurved: true, // Ensure lines are curved
        // Adjust curve smoothness if there are consecutive zeros
        curveSmoothness: hasConsecutiveZeros
            ? 0.0
            : 0.35, // Reduced default smoothness slightly
        color: lineColor,
        barWidth: 2, // Made lines slightly thinner
        isStrokeCapRound: true,
        dotData: FlDotData(
          // Configure data points (dots)
          // Show dots only if the month's tooltip is active
          checkToShowDot: (spot, barData) {
            return _showingTooltipOnMonths.contains(spot.x.toInt());
          },
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 4, // Dot size
            color: barData.color!, // Dot color matches line color
            strokeWidth: 1, // Border width
            strokeColor: Colors.black54, // Border color
          ),
        ),
        belowBarData: BarAreaData(
            show: false), // Hide area below the line (from original)
        spots: _dynamicSpots[i], // Use dynamic data for this line
      ));
    }
    return bars;
  }

  // Widget builder for the left axis titles (dynamic based on interval)
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    // Only show labels for values that are multiples of the interval
    if (value % _yInterval == 0) {
      return SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          value.toInt().toString(), // Display the integer value
          style: style,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container(); // Hide labels for other values
  }

  // Configuration for the left axis titles (dynamic interval)
  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets, // Use the custom widget builder
        showTitles: true, // Show the titles
        interval: _yInterval, // Use the dynamically calculated interval
        reservedSize: 40, // Reserve space for the titles
      );

  // Widget builder for the bottom axis titles (months) using dynamic labels
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: cyan600,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final int index = value.toInt();
    Widget textWidget = const Text(''); // Default empty widget

    // Use the dynamically generated month labels
    if (index >= 0 && index < _monthLabels.length) {
      textWidget = Text(_monthLabels[index], style: style);
    }

    return SideTitleWidget(
      space: 10, // Space between title and axis line
      axisSide: AxisSide.bottom,
      child: textWidget,
    );
  }

  // Configuration for the bottom axis titles
  SideTitles get bottomTitles => SideTitles(
        showTitles: true, // Show the titles
        reservedSize: 32, // Reserve space for the titles
        interval: 1, // Show titles at an interval of 1 to show all months
        getTitlesWidget: bottomTitleWidgets, // Use the custom widget builder
      );

  // Configuration for grid lines (horizontal dashed lines)
  FlGridData get gridData => FlGridData(
        show: true, // Show grid lines
        drawVerticalLine: false, // Hide vertical lines
        drawHorizontalLine: true, // Show horizontal lines
        getDrawingHorizontalLine: (value) {
          // Only draw lines at multiples of the yInterval
          if (value % _yInterval == 0) {
            return const FlLine(
              color: Color.fromARGB(134, 18, 124, 113), // Grid line color
              strokeWidth: 1,
              dashArray: [5, 5], // Make the line dashed
            );
          }
          return const FlLine(
              color: Colors.transparent); // Hide lines at other values
        },
        horizontalInterval:
            _yInterval, // Use the dynamically calculated interval
      );

  // Configuration for the chart border (from original)
  FlBorderData get borderData => FlBorderData(
        show: true, // Show the border
        border: Border(
          bottom: BorderSide(
            color:
                const Color.fromARGB(134, 18, 124, 113), // Bottom border color
          ),
          left: const BorderSide(
              color: Color.fromARGB(133, 18, 124, 113)), // Hide left border
          right:
              const BorderSide(color: Colors.transparent), // Hide right border
          top: const BorderSide(color: Colors.transparent), // Hide top border
        ),
      );

  @override
  Widget build(BuildContext context) {
    developer.log('Building DynamicMonthlyChart',
        name: 'DynamicMonthlyChart'); // Debug log

    // Build the list of ShowingTooltipIndicators based on the months with tooltips showing
    List<ShowingTooltipIndicators> tooltipIndicators = [];
    if (_showingTooltipOnMonths.isNotEmpty && _dynamicSpots.isNotEmpty) {
      for (int monthIndex in _showingTooltipOnMonths) {
        List<LineBarSpot> spotsForMonth = [];
        // Add a LineBarSpot for each line at the current month index
        for (int lineIndex = 0; lineIndex < _dynamicSpots.length; lineIndex++) {
          // Ensure the month index is within the bounds of the data for this line
          if (monthIndex < _dynamicSpots[lineIndex].length) {
            spotsForMonth.add(LineBarSpot(
                lineBarsData[lineIndex], // The LineChartBarData for this line
                lineIndex, // The index of this line bar
                _dynamicSpots[lineIndex]
                    [monthIndex] // The FlSpot for this month and line
                ));
          }
        }
        if (spotsForMonth.isNotEmpty) {
          tooltipIndicators.add(ShowingTooltipIndicators(spotsForMonth));
        }
      }
    }

    return LineChart(
      LineChartData(
        lineTouchData: lineTouchData, // Use the updated touch configuration
        gridData: gridData, // Grid lines configuration (dynamic and dashed)
        titlesData:
            titlesData, // Axis titles and labels configuration (dynamic Y-axis)
        borderData: borderData, // Chart border configuration (from original)
        lineBarsData:
            lineBarsData, // Data for the lines (dynamic, colors, dots, zero handling)
        minX: 0, // Minimum value for the X-axis
        // Determine maxX dynamically based on the number of months
        maxX: _getMaxX(),
        minY: 0, // Minimum value for the Y-axis is always 0
        // Determine maxY dynamically based on the maximum value across all data lists
        maxY: _maxY,
        // Provide the list of tooltip indicators directly to LineChartData
        showingTooltipIndicators: tooltipIndicators,
      ),
      duration: const Duration(milliseconds: 250), // Animation duration
    );
  }
}

// This widget manages the state and displays the DynamicMonthlyChart
class MonthlySessionsTypeChart extends StatefulWidget {
  // Accepts a single list of MonthlyMultiDataPoint
  const MonthlySessionsTypeChart({
    super.key,
    required this.data,
    required this.monthLabels, // Added monthLabels parameter
  });

  final List<TreatmentData> data; // Changed to List<TreatmentData>
  final List<String> monthLabels; // Added monthLabels parameter

  @override
  State<StatefulWidget> createState() => MonthlySessionsTypeChartState();
}

class MonthlySessionsTypeChartState extends State<MonthlySessionsTypeChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23, // Aspect ratio of the chart container
      child: Column(
        // Arrange chart elements vertically
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // const SizedBox(
          //   height: 37, // Spacing
          // ),
          // Removed the chart title Text widget
          // const SizedBox(
          //   height: 37, // Spacing
          // ),
          Expanded(
            // Allow the chart to fill available space
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 6), // Padding around the chart
              // Pass the dynamic TreatmentData list and month labels to the chart widget
              child: DynamicMonthlyChart(
                data: widget.data,
                monthLabels: widget.monthLabels,
              ),
            ),
          ),
          const SizedBox(
            height: 10, // Spacing
          ),
        ],
      ),
    );
  }
}

// Example of how a parent widget would use MonthlySessionsTypeChart
/*
class ParentWidget extends StatelessWidget {
  // Sample dynamic data using TreatmentData for January to June
  final List<TreatmentData> monthlyTreatmentData = [
    TreatmentData(name: 'Fillings', values: [190, 250, 0, 210, 240, 300]), // Values for Jan-Jun
    TreatmentData(name: 'Extractions', values: [130, 180, 200, 160, 190, 220]),
    TreatmentData(name: 'Cleanings', values: [80, 120, 0, 110, 130, 160]),
    TreatmentData(name: 'Root Canals', values: [50, 0, 90, 0, 0, 0]), // Example with missing values
    TreatmentData(name: 'Crowns', values: [0, 0, 60, 0, 0, 0]), // Example with missing values
  ];

  final List<String> months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو']; // Month labels

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Treatments Chart')),
      body: Center(
        child: MonthlySessionsTypeChart(
          data: monthlyTreatmentData,
          monthLabels: months,
        ),
      ),
    );
  }
}
*/
