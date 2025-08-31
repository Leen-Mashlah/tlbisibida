import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_cats.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/cat_management_dialog.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/secondary_chart.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_states.dart';

class InteractiveDonutChart extends StatefulWidget {
  const InteractiveDonutChart({super.key});

  @override
  _InteractiveDonutChartState createState() => _InteractiveDonutChartState();
}

class _InteractiveDonutChartState extends State<InteractiveDonutChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        final cubit = context.read<InventoryCubit>();
        final categories = cubit.categories;

        return Stack(
          alignment: Alignment.center,
          children: [
            if (categories.isNotEmpty)
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (event is FlTapUpEvent) {
                          touchedIndex = pieTouchResponse
                                  ?.touchedSection?.touchedSectionIndex ??
                              -1;
                          // Select the category when tapped
                          if (touchedIndex >= 0 &&
                              touchedIndex < categories.length) {
                            cubit.selectCategory(categories[touchedIndex]);
                          }
                        }
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 180,
                  sections: showingSections(categories),
                ),
              )
            else
              // Show empty state when no categories
              Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cyan50,
                  border: Border.all(color: cyan200, width: 2),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.category_outlined, size: 80, color: cyan300),
                      SizedBox(height: 16),
                      Text(
                        'لا توجد فئات',
                        style: TextStyle(
                          fontSize: 18,
                          color: cyan500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (touchedIndex != -1 && categories.isNotEmpty)
              SecondaryDonutChart(index: touchedIndex),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => BlocProvider.value(
                            value: cubit,
                            child: CatManagementDialog(context),
                          ));
                },
                icon: Icon(
                  Icons.settings,
                  color: cyan400,
                  size: 100,
                )),
          ],
        );
      },
    );
  }

  List<PieChartSectionData> showingSections(List<Category> categories) {
    if (categories.isEmpty) return [];

    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;

      // Generate different colors for each category
      final colors = [cyan500, cyan400, cyan300, cyan200, cyan100];
      final color = colors[i % colors.length];

      final category = categories[i];
      final title = category.name ?? 'Unknown';

      // Calculate percentage (equal distribution for now)
      final percentage = (100 / categories.length).round();

      return PieChartSectionData(
        color: color,
        value: percentage.toDouble(),
        title: title.length > 8 ? '${title.substring(0, 8)}...' : title,
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
      );
    });
  }
}
