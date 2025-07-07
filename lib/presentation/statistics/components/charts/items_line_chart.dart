import 'package:dotted_border/dotted_border.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/searchable_drop.dart';

class LineChartSample20 extends StatefulWidget {
  const LineChartSample20({super.key});

  @override
  State<LineChartSample20> createState() => _LineChartSample20State();
}

class _LineChartSample20State extends State<LineChartSample20> {
  List<Color> gradientColors = [
    const Color.fromARGB(175, 143, 229, 220),
    const Color.fromARGB(175, 48, 195, 178),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.3,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 0, right: 16, left: 16),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DottedBorder(
              radius: Radius.circular(20),
              borderType: BorderType.RRect,
              dashPattern: [5, 2],
              color: cyan200,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(cyan100),

                  // side: WidgetStatePropertyAll(BorderSide())
                ),
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: Text(
                  'متوسط الاستهلاك',
                  style: TextStyle(
                    fontSize: 12,
                    color: showAvg ? cyan400 : cyan500,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: SearchableExpandableDropdown(
                data: [
                  CategoryItem(
                    categoryName: 'بلوكات زيركون',
                    items: ['صيني', 'الماني', 'امريكي'],
                  ),
                  CategoryItem(
                    categoryName: 'خزف',
                    items: ['ملمع', 'منخفض انصهار', 'عالي انصهار', 'بوستر'],
                  ),
                  CategoryItem(
                    categoryName: 'رمل',
                    items: ['ناعم', 'خشن'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text =
            const Text('يناير', style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 2:
        text = const Text('فبراير',
            style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 3:
        text =
            const Text('مارس', style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 4:
        text =
            const Text('ابريل', style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 5:
        text =
            const Text('مايو', style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 6:
        text =
            const Text('يونيو', style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 7:
        text =
            const Text('يوليو', style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 8:
        text =
            const Text('اغسطس', style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 9:
        text = const Text('سبتمبر',
            style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 10:
        text = const Text('اكتوبر',
            style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 11:
        text = const Text('نوفمبر',
            style: TextStyle(color: cyan500, fontSize: 14));
        break;
      case 12:
        text = const Text('ديسمبر',
            style: TextStyle(color: cyan500, fontSize: 14));
      case 13:
        text = const Text('', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: cyan500,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1K';
        break;
      case 2:
        text = '2k';
        break;
      case 3:
        text = '3k';
        break;
      case 4:
        text = '4k';
        break;
      case 5:
        text = '5k';
        break;
      case 6:
        text = '6k';
        break;
      case 7:
        text = '7k';
      case 8:
        text = '8k';
      case 9:
        text = '9k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: cyan300,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: cyan400,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 13,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 0),
            FlSpot(1, 6),
            FlSpot(2, 8),
            FlSpot(3, 6.1),
            FlSpot(4, 4),
            FlSpot(5, 6),
            FlSpot(6, 4),
            FlSpot(7, 7.5),
            FlSpot(8, 4.1),
            FlSpot(9, 5),
            FlSpot(10, 7),
            FlSpot(11, 4),
            FlSpot(12, 8.5),
            FlSpot(13, 5),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color).toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!,
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
              ],
            ),
          ),
        ),
      ],
    );
  }
}
