import 'package:dotted_border/dotted_border.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/searchable_drop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/presentation/statistics/cubit/statistics_cubit.dart';
import 'package:lambda_dent_dash/presentation/statistics/cubit/statistics_state.dart';

class LineChartSample20 extends StatefulWidget {
  const LineChartSample20({super.key, required this.monthlyData});

  final List<Map<String, dynamic>> monthlyData; // [{month:int, value:double}]

  @override
  State<LineChartSample20> createState() => _LineChartSample20State();
}

class _LineChartSample20State extends State<LineChartSample20> {
  List<Color> gradientColors = [
    const Color.fromARGB(175, 143, 229, 220),
    const Color.fromARGB(175, 48, 195, 178),
  ];

  bool showAvg = false;

  List<FlSpot> _spots = const [];

  @override
  void initState() {
    super.initState();
    _spots = _buildSpots(widget.monthlyData);
  }

  @override
  void didUpdateWidget(covariant LineChartSample20 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.monthlyData != widget.monthlyData) {
      setState(() {
        _spots = _buildSpots(widget.monthlyData);
      });
    }
  }

  List<FlSpot> _buildSpots(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return const [];
    final points = List<FlSpot>.from(
      data.map((e) => FlSpot(
          (e['month'] as num).toDouble(), (e['value'] as num).toDouble())),
    );
    points.sort((a, b) => a.x.compareTo(b.x));
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.3,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 0, right: 16, left: 16),
            child: LineChart(showAvg ? avgData() : mainData()),
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
              child: BlocBuilder<StatisticsCubit, StatisticsState>(
                builder: (context, state) {
                  final List<CategoryItem> dropdownData;
                  if (state is StatisticsLoaded && state.itemsList.isNotEmpty) {
                    final itemNames = state.itemsList
                        .map((e) => (e['name'] ?? '').toString())
                        .where((name) => name.isNotEmpty)
                        .toList();
                    dropdownData = [
                      CategoryItem(categoryName: 'المواد', items: itemNames),
                    ];
                  } else {
                    dropdownData = [
                      CategoryItem(categoryName: 'المواد', items: [])
                    ];
                  }
                  return SearchableExpandableDropdown(
                    data: dropdownData,
                  );
                },
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
      maxY: _spots.isEmpty
          ? 10
          : (_spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.2),
      lineBarsData: [
        LineChartBarData(
          spots: _spots.isEmpty ? const [FlSpot(0, 0)] : _spots,
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
