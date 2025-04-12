import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:lambda_dent_dash/constant/components/custom_text.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';

/// Example without datasource
// ignore: must_be_immutable
class PaymentLogTable extends StatelessWidget {
  const PaymentLogTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: cyan200, width: .5),
          boxShadow: const [
            BoxShadow(offset: Offset(0, 6), color: Colors.grey, blurRadius: 12)
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
                    'المبلغ المضاف',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'تاريخ الدفع',
                    style: TextStyle(color: cyan300),
                  )),
                ),
              ],
              rows: List<DataRow>.generate(
                50,
                (index) => DataRow(
                  cells: [
                    const DataCell(Center(
                        child: CustomText(
                      text: '1.000.000',
                    ))),
                    const DataCell(
                        Center(child: CustomText(text: '5/11/2024'))),
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
