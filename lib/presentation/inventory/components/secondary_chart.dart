import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_subcats.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_states.dart';

class SecondaryDonutChart extends StatelessWidget {
  final int index;

  const SecondaryDonutChart({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        final cubit = context.read<InventoryCubit>();
        final subCategories = cubit.subCategories;

        return SizedBox(
          width: 200,
          height: 200,
          child: subCategories.isNotEmpty
              ? PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (event is FlTapUpEvent) {
                          final touchedIndex = pieTouchResponse
                                  ?.touchedSection?.touchedSectionIndex ??
                              -1;
                          if (touchedIndex >= 0 &&
                              touchedIndex < subCategories.length) {
                            cubit
                                .selectSubCategory(subCategories[touchedIndex]);
                          }
                        }
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 120,
                    sections: showingSections(subCategories),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cyan50,
                    border: Border.all(color: cyan200, width: 1),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.subdirectory_arrow_right,
                            size: 40, color: cyan300),
                        SizedBox(height: 8),
                        Text(
                          'لا توجد فئات فرعية',
                          style: TextStyle(
                            fontSize: 12,
                            color: cyan500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSections(
      List<SubCategoryRepository> subCategories) {
    if (subCategories.isEmpty) return [];

    return List.generate(subCategories.length, (i) {
      final subCategory = subCategories[i];
      final title = subCategory.name ?? 'Unknown';

      // Generate different colors for each subcategory
      final colors = [
        Colors.blue,
        Colors.yellow,
        Colors.pink,
        Colors.green,
        Colors.orange,
        Colors.purple
      ];
      final color = colors[i % colors.length];

      // Calculate percentage (equal distribution for now)
      final percentage = (100 / subCategories.length).round();

      return PieChartSectionData(
        color: color[300]!,
        value: percentage.toDouble(),
        title: title.length > 6 ? '${title.substring(0, 6)}...' : title,
        radius: 50,
        titleStyle: TextStyle(
            fontSize: 12,
            color: color[700]!.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white),
      );
    });
  }
}
