import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

/// Example without datasource
// ignore: must_be_immutable
class ItemLogTable extends StatelessWidget {
  const ItemLogTable({super.key});

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
                'القيمة السابقة',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'الفرق',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'القيمة الجديدة',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'السعر',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'التاريخ',
                style: TextStyle(color: cyan300),
              )),
            ),
          ],
          rows: List<DataRow>.generate(
            20,
            (index) => const DataRow(
              cells: [
                DataCell(Center(
                    child: CustomText(
                  text: '50',
                ))),
                DataCell(Center(child: CustomText(text: '+300'))),
                DataCell(Center(child: CustomText(text: '350'))),
                DataCell(Center(child: CustomText(text: '1000'))),
                DataCell(Center(child: CustomText(text: '7/8/2024'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
