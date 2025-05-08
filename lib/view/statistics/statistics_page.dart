import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/view/statistics/components/cases_chart.dart';
import 'package:lambda_dent_dash/view/statistics/components/line_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SizedBox(
              width: 500,
              child: LineChartSample5(),
            ),
            SizedBox(
              width: 500,
              child: LineChartSample2(),
            )
          ],
        ),
      ),
    );
  }
}
