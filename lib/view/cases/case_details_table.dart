import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:lambda_dent_dash/constant/components/custom_text.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/view/bills/components/bill_details_dialog.dart';

/// Example without datasource
// ignore: must_be_immutable
class CaseDetailsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: cyan200, width: .5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6), color: Colors.grey, blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        // margin: const EdgeInsets.only(bottom: 30),
        child: DataTable2(
          columnSpacing: 12,
          dataRowHeight: 56,
          headingRowHeight: 40,
          horizontalMargin: 12,
          minWidth: 100,
          columns: const [
            DataColumn(
              label: Center(
                  child: Text(
                'رقم السن',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'العلاج',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'مادة العلاج',
                style: TextStyle(color: cyan300),
              )),
            ),
          ],
          rows: List<DataRow>.generate(
            20,
            (index) => DataRow(
              cells: [
                DataCell(Center(
                    child: CustomText(
                  text: '11',
                ))),
                DataCell(Center(child: CustomText(text: 'دمية'))),
                DataCell(Center(child: CustomText(text: 'زيركون'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
