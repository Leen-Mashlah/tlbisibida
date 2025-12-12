import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SecondaryDonutChart extends StatelessWidget {
  final int index;

  const SecondaryDonutChart({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(enabled: false),
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 120,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    switch (index) {
      case 0:
        return [
          PieChartSectionData(
              color: Colors.blue[100],
              value: 50,
              title: '50%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
          PieChartSectionData(
              color: Colors.blue[300],
              value: 50,
              title: '50%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
        ];
      case 1:
        return [
          PieChartSectionData(
              color: Colors.yellow[100],
              value: 30,
              title: '30%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.black)),
          PieChartSectionData(
              color: Colors.yellow[300],
              value: 30,
              title: '30%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.black)),
          PieChartSectionData(
              color: Colors.yellow[700],
              value: 40,
              title: '40%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.black)),
        ];
      case 2:
        return [
          PieChartSectionData(
              color: Colors.pink[100],
              value: 25,
              title: '25%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
          PieChartSectionData(
              color: Colors.pink[300],
              value: 25,
              title: '25%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
          PieChartSectionData(
              color: Colors.pink[500],
              value: 25,
              title: '25%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
          PieChartSectionData(
              color: Colors.pink[700],
              value: 25,
              title: '25%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
        ];
      case 3:
        return [
          PieChartSectionData(
              color: Colors.green[100],
              value: 60,
              title: '60%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.black)),
          PieChartSectionData(
              color: Colors.green[700],
              value: 40,
              title: '40%',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, color: Colors.white)),
        ];
      default:
        return [];
    }
  }
}
