import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/statistics/components/charts/inventory_count_chart.dart';
import 'package:lambda_dent_dash/view/statistics/components/charts/monthly_op_expenses_chart.dart';
import 'package:lambda_dent_dash/view/statistics/components/taps.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  final List<String> _choices = ['المدفوعات', 'الأرباح', 'المواد'];
  final ValueNotifier<String> _table = ValueNotifier<String>('المدفوعات');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DottedBorder(
            borderType: BorderType.Rect,
            color: cyan400,
            dashPattern: const [9, 2],
            child: Container(
              decoration: BoxDecoration(
                  color: cyan100,
                  border: Border.all(color: cyan300, width: .2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Taps(choices: _choices, type: _table),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 130,
              height: MediaQuery.of(context).size.height / 1,
              decoration: BoxDecoration(
                  color: cyan200,
                  border: Border.all(
                    color: cyan100,
                    width: .5,
                  )),
              child: AnimatedBuilder(
                  animation: _table,
                  builder: (context, child) => (_table.value == 'المدفوعات')
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: cyan100,
                                  borderRadius: BorderRadius.circular(20)),
                              width: 600,
                              height: 655,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text('مدفوعات المخزن',
                                      style: TextStyle(
                                          color: cyan600, fontSize: 16)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: .5,
                                    color:
                                        cyan400, // Assuming cyan400 is a desired color for the divider
                                    width: 200,
                                    // margin: const EdgeInsets.symmetric(
                                    //     vertical: 20), // Add some margin
                                  ),
                                  const InventoryCountChart(
                                    rawChartData: [
                                      {
                                        'text': 'معدن صب',
                                        'count': '320',
                                        'value': 874100.0
                                      },
                                      {
                                        'text': 'إكريل',
                                        'count': '10',
                                        'value': 200000.0
                                      },
                                      {
                                        'text': 'خزف',
                                        'count': '5',
                                        'value': 400000.0
                                      },
                                      {
                                        'text': 'بلوكات',
                                        'count': '65',
                                        'value': 980000.0
                                      },
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: cyan100,
                                  borderRadius: BorderRadius.circular(20)),
                              width: 600,
                              height: 655,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text('المدفوعات التشغيلية',
                                      style: TextStyle(
                                          color: cyan600, fontSize: 16)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: .5,
                                    color:
                                        cyan400, // Assuming cyan400 is a desired color for the divider
                                    width: 200,
                                    // margin: const EdgeInsets.symmetric(
                                    //     vertical: 20), // Add some margin
                                  ),
                                  const MonthlyOpExpensesChart()
                                ],
                              ),
                            ),
                          ],
                        )
                      : (_table.value == 'الأرباح')
                          ? Text('dataaaaaa')
                          : Text('data')),
            ),
          )
        ],
      ),
    );
  }
}
