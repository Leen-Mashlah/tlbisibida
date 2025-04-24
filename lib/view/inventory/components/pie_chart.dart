import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/cat_management_dialog.dart';
import 'package:lambda_dent_dash/view/inventory/components/secondary_chart.dart';

class InteractiveDonutChart extends StatefulWidget {
  const InteractiveDonutChart({super.key});

  @override
  _InteractiveDonutChartState createState() => _InteractiveDonutChartState();
}

class _InteractiveDonutChartState extends State<InteractiveDonutChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (event is FlTapUpEvent) {
                    touchedIndex =
                        pieTouchResponse?.touchedSection?.touchedSectionIndex ??
                            -1;
                  }
                });
              },
            ),
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 180,
            sections: showingSections(),
          ),
        ),
        if (touchedIndex != -1) SecondaryDonutChart(index: touchedIndex),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => CatManagementDialog(context));
            },
            icon: Icon(
              Icons.settings,
              color: cyan400,
              size: 100,
            )),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: cyan500,
            value: 40,
            title: 'Blocks',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: cyan400,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: cyan300,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: cyan200,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        default:
          throw Error();
      }
    });
  }
}
