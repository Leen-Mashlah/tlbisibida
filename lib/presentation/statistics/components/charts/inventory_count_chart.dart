import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/charts/indicator.dart';

class ChartData {
  final String text;
  final double value;
  final double count;
  final Color color;

  ChartData(
      {required this.text,
      required this.value,
      required this.count,
      required this.color});
}

class InventoryCountChart extends StatefulWidget {
  const InventoryCountChart({
    super.key,
    required this.rawChartData,
  });

  final List<Map<String, dynamic>> rawChartData;

  @override
  State<StatefulWidget> createState() => InventoryCountChartState();
}

class InventoryCountChartState extends State<InventoryCountChart> {
  int touchedIndex = -1;

  // Original Color ranges (Cyan/Green and Pink)
  final List<Color> cyanColorRange = [
    cyan400, // Assuming this is a green/cyan shade
    cyan200, // Assuming this is a lighter green/cyan shade
  ];

  final List<Color> pinkColorRange = [
    const Color.fromARGB(255, 255, 229, 225), // Lighter pink
    const Color.fromARGB(255, 201, 118, 114), // Darker pink
  ];

  // Lists to hold processed data for the value chart
  List<ChartData> _valueChartData = [];

  @override
  void initState() {
    super.initState();
    // Use widget.rawChartData to access the data passed to the widget
    _processRawData(widget.rawChartData);
  }

  @override
  void didUpdateWidget(covariant InventoryCountChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-process data if the input rawChartData changes
    if (oldWidget.rawChartData != widget.rawChartData) {
      _processRawData(widget.rawChartData);
      // Optionally reset touchedIndex if data changes
      touchedIndex = -1;
    }
  }

  // Processes the raw data. Colors are assigned based on the order
  // after sorting by 'value', and these colors are then used for
  // both the value-sorted and count-sorted data lists.
  void _processRawData(List<Map<String, dynamic>> rawData) {
    // 1. Sort the raw data by 'value' first
    final List<Map<String, dynamic>> sortedRawValueData = List.from(rawData)
      ..sort((a, b) => b['value'].compareTo(a['value']));

    // 2. Assign colors based on the order in the value-sorted list
    final List<ChartData> processedValueSortedDataWithColors =
        List.generate(sortedRawValueData.length, (index) {
      final data = sortedRawValueData[index];
      final int midpoint = (sortedRawValueData.length / 2)
          .ceil(); // Midpoint based on value-sorted data length
      Color generatedColor;

      // Apply the original color distribution logic based on value-sorted index
      if (index < midpoint) {
        final double t = midpoint > 1 ? index / (midpoint - 1) : 0.0;
        generatedColor = Color.lerp(
          cyanColorRange.first, // Use cyan range for the first half
          cyanColorRange.last,
          t,
        )!;
      } else {
        final int secondHalfLength = sortedRawValueData.length - midpoint;
        final double t = secondHalfLength > 1
            ? (index - midpoint) / (secondHalfLength - 1)
            : 0.0;
        generatedColor = Color.lerp(
          pinkColorRange.first, // Use pink range for the second half
          pinkColorRange.last,
          t,
        )!;
      }

      return ChartData(
        text: data['text'].toString(),
        value: data['value'] as double,
        count: data['count'] is String
            ? double.parse(data['count'])
            : data['count'] as double, // Handle potential string count
        color: generatedColor, // Color assigned based on value-sorted position
      );
    });

    // 3. The value chart data is the processed list directly
    _valueChartData = processedValueSortedDataWithColors;
  }

  // Generates the list of PieChartSectionData for the Value Chart (Top)
  List<PieChartSectionData> _showingValueSections() {
    double totalValue =
        _valueChartData.fold(0, (sum, item) => sum + item.value);

    return List.generate(_valueChartData.length, (i) {
      final isTouched =
          i == touchedIndex; // Check if the current section is touched
      final fontSize = isTouched ? 18.0 : 16.0; // Adjust font size if touched
      final radius = isTouched ? 90.0 : 80.0; // Adjust radius if touched
      const shadows = [
        Shadow(color: Colors.black, blurRadius: 10)
      ]; // Text shadow

      final data = _valueChartData[i]; // Get the data for the current index
      // Calculate the percentage for the current section
      final percentage = totalValue > 0
          ? (data.value / totalValue) * 100
          : 0.0; // Avoid division by zero

      return PieChartSectionData(
        color: data.color, // Use the color assigned based on value-sorted order
        value: data.value, // Use the actual value for the chart segment size
        title:
            '${percentage.toStringAsFixed(1)}%', // Display calculated percentage with one decimal place
        radius: radius, // Set the radius
        titleStyle: TextStyle(
          // Style for the percentage text
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: white, // Assuming 'white' is defined in your constants
          shadows: shadows,
        ),
      );
    });
  }

  // Helper to format large numbers with commas
  String formatNumber(double number) {
    final formatter = NumberFormat(
        '#,##0', 'en_US'); // Use 'en_US' locale for comma separation
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            // Use Expanded to give the chart flexible space
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                // Use Stack to place charts on top of each other
                alignment: Alignment.center, // Center the stacked charts
                children: [
                  // Top Chart (Value)
                  PieChart(
                    PieChartData(
                      // Enable touch interactions for the top chart
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: .5, // Spacing between sections
                      centerSpaceRadius: 50, // Radius of the central hole
                      sections:
                          _showingValueSections(), // Use value-based sections
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider line
          Container(
            height: .5,
            color:
                cyan400, // Assuming cyan400 is a desired color for the divider
            width: 200,
            margin: const EdgeInsets.symmetric(vertical: 50), // Add some margin
          ),
          // Section for indicators, wrapped in SingleChildScrollView
          SizedBox(
            height: 150, // Give the indicator column a fixed height
            child: SingleChildScrollView(
              // Allow scrolling if there are many indicators
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _valueChartData.asMap().entries.map((entry) {
                  ChartData data = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0), // Add padding between indicators
                    child: Indicator(
                      color: data
                          .color, // Use the color assigned based on value-sorted order
                      text: data.text, // Use the text from the data
                      value: formatNumber(
                          data.value), // Format and display the value
                      count: data.count, // Pass the count to the Indicator
                      isSquare: true,
                    ),
                  );
                }).toList(), // Convert the map result to a list of Widgets
              ),
            ),
          ),
          // const SizedBox(
          //   height: 18, // Spacing at the bottom
          // ),
        ],
      ),
    );
  }
}

// Helper function (remains the same)
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
