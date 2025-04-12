import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:lambda_dent_dash/constant/components/custom_text.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';

/// Example without datasource
// ignore: must_be_immutable
class ClientsTable extends StatelessWidget {
  const ClientsTable({super.key});

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
                    'التفاصيل',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'اسم الزبون',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'رقم الهاتف',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'العنوان',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'تاريخ الانضمام',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'الرصيد',
                    style: TextStyle(color: cyan300),
                  )),
                ),
              ],
              rows: List<DataRow>.generate(
                50,
                (index) => DataRow(
                  cells: [
                    DataCell(Center(
                        child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/client_details');
                      },
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: cyan300,
                      ),
                    ))),
                    const DataCell(Center(
                        child: CustomText(
                      text: 'تحسين',
                    ))),
                    const DataCell(
                        Center(child: CustomText(text: '0992532588'))),
                    const DataCell(Center(child: CustomText(text: 'هونولولو'))),
                    const DataCell(
                        Center(child: CustomText(text: '10/4/2024'))),
                    const DataCell(Center(child: CustomText(text: '350000'))),
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
