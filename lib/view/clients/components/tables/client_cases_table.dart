import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:lambda_dent_dash/constant/components/custom_text.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/view/bills/components/bill_details_dialog.dart';

/// Example without datasource
// ignore: must_be_immutable
class ClientCasesTable extends StatelessWidget {
  const ClientCasesTable({super.key});

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
                    ' وضع الحالة',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'اسم المريض',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'تاريخ الحالة',
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
                        locator<NavigationService>()
                            .navigateTo(caseDetailsPageRoute);
                      },
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: cyan300,
                      ),
                    ))),
                    const DataCell(Center(
                        child: CustomText(
                      text: 'جاهزة',
                    ))),
                    const DataCell(Center(child: CustomText(text: 'تحسين'))),
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
