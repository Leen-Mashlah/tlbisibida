import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/charts/inventory_count_chart.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/charts/items_line_chart.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/charts/monthly_financial_chart.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/charts/monthly_op_expenses_chart.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/charts/monthly_teeth_type_chart.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/charts/revenue_per_client.dart';
import 'package:lambda_dent_dash/presentation/statistics/components/taps.dart';

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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        ? SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cyan100,
                                        border: Border.all(
                                          color: cyan300,
                                          width: .5,
                                        )),
                                    width: MediaQuery.of(context).size.width /
                                            1.9 -
                                        130,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text('الزبائن الأكثر مردودا',
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
                                        RevenuePerClientChart(
                                          clientRevenueData: const [
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 8000000,
                                              shadowValue: 186028,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 7500000,
                                              shadowValue: 35228,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 7000000,
                                              shadowValue: 332250,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 6000000,
                                              shadowValue: 402250,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 5000000,
                                              shadowValue: 1252250,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 4000000,
                                              shadowValue: 1422530,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 3000000,
                                              shadowValue: 1552250,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 2000000,
                                              shadowValue: 22267,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 1000000,
                                              shadowValue: 20750,
                                            ),
                                            ClientData(
                                              name: 'تحسين التحسيني',
                                              value: 500000,
                                              shadowValue: 274750,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /
                                            1.9 -
                                        130,
                                    height: MediaQuery.of(context).size.height /
                                        1.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cyan100,
                                        border: Border.all(
                                          color: cyan300,
                                          width: .5,
                                        )),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text('الأرباح شهريا',
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
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.2,
                                          child:
                                              MonthlyFinancialChart(chartData: [
                                            MonthlyFinancialData(
                                                id: 0,
                                                month: 'يناير',
                                                revenue: 9500,
                                                expenses: 5500),
                                            MonthlyFinancialData(
                                                id: 1,
                                                month: 'فبراير',
                                                revenue: 3500,
                                                expenses: 5500),
                                            MonthlyFinancialData(
                                                id: 2,
                                                month: 'مارس',
                                                revenue: 6000,
                                                expenses: 4000),
                                            MonthlyFinancialData(
                                                id: 3,
                                                month: 'ابريل',
                                                revenue: 7000,
                                                expenses: 7000),
                                            MonthlyFinancialData(
                                                id: 4,
                                                month: 'مايو',
                                                revenue: 6600,
                                                expenses: 6500),
                                            MonthlyFinancialData(
                                                id: 5,
                                                month: 'يونيو',
                                                revenue: 6000,
                                                expenses: 6500),
                                            MonthlyFinancialData(
                                                id: 6,
                                                month: 'يوليو',
                                                revenue: 1000,
                                                expenses: 5500),
                                            MonthlyFinancialData(
                                                id: 7,
                                                month: 'اغسطس',
                                                revenue: 3500,
                                                expenses: 5500),
                                            MonthlyFinancialData(
                                                id: 8,
                                                month: 'سبتمبر',
                                                revenue: 6000,
                                                expenses: 4000),
                                            MonthlyFinancialData(
                                                id: 9,
                                                month: 'اكتوبر',
                                                revenue: 4000,
                                                expenses: 7000),
                                            MonthlyFinancialData(
                                                id: 10,
                                                month: 'نوفمبر',
                                                revenue: 4000,
                                                expenses: 6500),
                                            MonthlyFinancialData(
                                                id: 11,
                                                month: 'ديسمبر',
                                                revenue: 6000,
                                                expenses: 6500),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: cyan100,
                                      border: Border.all(
                                        color: cyan300,
                                        width: .5,
                                      )),
                                  width:
                                      MediaQuery.of(context).size.width / 1.9 -
                                          130,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text('عدد القطع المصنعة شهريا',
                                          style: TextStyle(
                                              color: cyan600, fontSize: 16)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: .5,
                                        color: cyan400,
                                        width: 200,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      MonthlySessionsTypeChart(data: [
                                        TreatmentData(name: 'زيركون', values: [
                                          190,
                                          250,
                                          100,
                                          110,
                                          60,
                                          180,
                                          290,
                                          370,
                                          0,
                                          210,
                                          240,
                                          300
                                        ]), // Values for Jan-Jun
                                        TreatmentData(name: 'خزف', values: [
                                          130,
                                          180,
                                          200,
                                          160,
                                          190,
                                          100,
                                          100,
                                          110,
                                          60,
                                          180,
                                          290,
                                          220
                                        ]),
                                        TreatmentData(name: 'شمع', values: [
                                          80,
                                          120,
                                          150,
                                          100,
                                          110,
                                          100,
                                          110,
                                          60,
                                          180,
                                          290,
                                          130,
                                          160
                                        ]),
                                        TreatmentData(name: 'EMax', values: [
                                          50,
                                          350,
                                          100,
                                          110,
                                          60,
                                          180,
                                          290,
                                          370,
                                          90,
                                          0,
                                          200,
                                          0
                                        ]), // Example with missing values
                                        TreatmentData(
                                            name: 'اكريل مؤقت',
                                            values: [
                                              100,
                                              110,
                                              60,
                                              180,
                                              290,
                                              110,
                                              60,
                                              180,
                                              290,
                                              370,
                                              200,
                                              20
                                            ]), // Example with missing values
                                        TreatmentData(
                                            name: 'اكريل مبطن',
                                            values: [
                                              50,
                                              100,
                                              110,
                                              60,
                                              180,
                                              290,
                                              100,
                                              110,
                                              60,
                                              180,
                                              290,
                                              10
                                            ]), // Example with missing values
                                        TreatmentData(name: 'فليكس', values: [
                                          50,
                                          350,
                                          90,
                                          50,
                                          200,
                                          100,
                                          110,
                                          60,
                                          180,
                                          290,
                                          290,
                                          370
                                        ]), // Example with missing values
                                        // Example with missing values
                                      ], monthLabels: const [
                                        'يناير',
                                        'فبراير',
                                        'مارس',
                                        'أبريل',
                                        'مايو',
                                        'يونيو',
                                        'يوليو',
                                        'أغسطس',
                                        'سبتمبر',
                                        'أكتوبر',
                                        'نوفمبر',
                                        'ديسمبر',
                                      ] // Month labels

                                          ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: cyan100,
                                      border: Border.all(
                                        color: cyan300,
                                        width: .5,
                                      )),
                                  width:
                                      MediaQuery.of(context).size.width / 1.9 -
                                          130,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text('استهلاك مادة معينة شهريا',
                                          style: TextStyle(
                                              color: cyan600, fontSize: 16)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: .5,
                                        color: cyan400,
                                        width: 200,
                                      ),
                                      const SizedBox(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 50.0,
                                        ),
                                        child: LineChartSample20(),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
