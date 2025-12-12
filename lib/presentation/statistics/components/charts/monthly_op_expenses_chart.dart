// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:fl_chart_app/presentation/widgets/indicator.dart';
import 'package:flutter/material.dart';
// Assuming this contains your Indicator widget
import 'package:intl/intl.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/statistics/components/charts/indicator.dart'; // Import for number formatting
// import 'dart:math'; // Import for random number generation (not needed for this approach)

// Define a class to hold the data for each section
class ChartData {
  final String text;
  final double value;
  final Color color; // Color is now assigned dynamically

  ChartData({required this.text, required this.value, required this.color});
}

class MonthlyOpExpensesChart extends StatefulWidget {
  const MonthlyOpExpensesChart({super.key});

  @override
  State<StatefulWidget> createState() => MonthlyOpExpensesChartState();
}

class MonthlyOpExpensesChartState extends State {
  int touchedIndex = -1;

  // Define the raw data for the pie chart sections
  final List<Map<String, dynamic>> rawChartData = [
    {'text': 'مواصلات', 'value': 500000.0},
    {'text': 'رواتب', 'value': 2000000.0},
    {'text': 'كهرباء', 'value': 400000.0},
    {'text': 'وقود', 'value': 600000.0},
    {'text': 'آجار مكان', 'value': 2500000.0},
    // {'text': 'ماء', 'value': 100000.0},
    {'text': 'تدفئة', 'value': 1500000.0},
    {'text': 'نت', 'value': 300000.0},
  ];

  final List<Color> cyanColorRange = [
    cyan400,
    cyan200,
  ];

  final List<Color> pinkColorRange = [
    const Color.fromARGB(255, 255, 229, 225),
    const Color.fromARGB(255, 201, 118, 114),
  ];

  // Sort the raw data by value in ascending order
  late final List<Map<String, dynamic>> sortedRawChartData =
      List.from(rawChartData)..sort((a, b) => b['value'].compareTo(a['value']));

  // Process sorted raw data to create ChartData objects with sequential gradient colors
  late final List<ChartData> chartData =
      List.generate(sortedRawChartData.length, (index) {
    final data = sortedRawChartData[index];

    // Calculate the midpoint of the data list
    final int midpoint = (sortedRawChartData.length / 2).ceil();

    Color generatedColor;

    if (index < midpoint) {
      // For the first half, use the cyan gradient
      // Calculate t relative to the first half's length
      final double t = midpoint > 1 ? index / (midpoint - 1) : 0.0;
      generatedColor = Color.lerp(
        cyanColorRange.first,
        cyanColorRange.last,
        t,
      )!;
    } else {
      // For the second half, use the pink gradient
      // Calculate t relative to the second half's length
      final double t = (sortedRawChartData.length - midpoint) > 1
          ? (index - midpoint) / (sortedRawChartData.length - midpoint - 1)
          : 0.0;
      generatedColor = Color.lerp(
        pinkColorRange.first,
        pinkColorRange.last,
        t,
      )!;
    }

    return ChartData(
      text: data['text'],
      value: data['value'],
      color: generatedColor, // Assign the uniquely generated color
    );
  });

  // Calculate the total value dynamically from the chartData list
  double get totalValue => chartData.fold(0, (sum, item) => sum + item.value);

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
              child: PieChart(
                PieChartData(
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
                      showingSections(), // Generate sections based on data
                ),
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
                children: chartData.asMap().entries.map((entry) {
                  // Iterate through the chartData to create an Indicator for each item
                  int index = entry.key;
                  ChartData data = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0), // Add padding between indicators
                    child: Indicator(
                      color: data.color, // Use the dynamically assigned color
                      text: data.text, // Use the text from the data
                      value: formatNumber(
                          data.value), // Format and display the value
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

  // Generates the list of PieChartSectionData based on the chartData
  List<PieChartSectionData> showingSections() {
    return List.generate(chartData.length, (i) {
      final isTouched =
          i == touchedIndex; // Check if the current section is touched
      final fontSize = isTouched ? 18.0 : 16.0; // Adjust font size if touched
      final radius = isTouched ? 90.0 : 80.0; // Adjust radius if touched
      const shadows = [
        Shadow(color: Colors.black, blurRadius: 10)
      ]; // Text shadow

      final data = chartData[i]; // Get the data for the current index
      // Calculate the percentage for the current section
      final percentage = totalValue > 0
          ? (data.value / totalValue) * 100
          : 0.0; // Avoid division by zero

      return PieChartSectionData(
        color: data.color, // Use the dynamically assigned color
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
}
