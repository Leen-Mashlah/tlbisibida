import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

/// Example without datasource
// ignore: must_be_immutable
class PaymentsLogTable extends StatelessWidget {
  const PaymentsLogTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: cyan200, width: .5),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 6), color: Colors.grey, blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: (56 * 50) + 40,
            child: DataTable2(
              columnSpacing: 12,
              dataRowHeight: 56,
              headingRowHeight: 40,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn(
                  label: Center(
                      child: Text(
                    'تاريخ الشراء',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'البائع',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'المجموع',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'سعر العنصر الواحد',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'العدد/الكمية',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'اسم العنصر',
                    style: TextStyle(color: cyan300),
                  )),
                ),
              ],
              rows: List<DataRow>.generate(
                50,
                (index) => const DataRow(
                  cells: [
                    // DataCell(Center(
                    //     child: IconButton(
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => BillDetailsDialog(),
                    //     );
                    //   },
                    //   icon: Icon(
                    //     Icons.arrow_circle_left_outlined,
                    //     color: cyan300,
                    //   ),
                    // ))),
                    DataCell(Center(child: CustomText(text: '5/11/2024'))),

                    DataCell(Center(
                        child: CustomText(
                      text: 'تحسين',
                    ))),
                    DataCell(Center(
                        child: CustomText(
                      text: '50.000',
                    ))),
                    DataCell(Center(
                        child: CustomText(
                      text: '50.000',
                    ))),
                    DataCell(Center(
                        child: CustomText(
                      text: '50',
                    ))),
                    DataCell(Center(
                        child: CustomText(
                      text: 'امريكي',
                    ))),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
