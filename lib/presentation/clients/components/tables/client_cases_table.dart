import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

// ignore: must_be_immutable
class ClientCasesTable extends StatelessWidget {
  const ClientCasesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final clientsCubit = context.read<ClientsCubit>();

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
                    'اسم المريض',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'وضع الحالة',
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
                DataColumn(
                  label: Center(
                      child: Text(
                    'التفاصيل',
                    style: TextStyle(color: cyan300),
                  )),
                ),
              ],
              rows: List<DataRow>.generate(
                clientsCubit.casesList!.dentistCases.length,
                (index) {
                  var caseitem = clientsCubit.casesList!.dentistCases[index];
                  return DataRow(
                    cells: [
                      DataCell(
                          Center(child: Text(caseitem.patient!.fullName!))),
                      DataCell(Center(
                          child: CustomText(
                        text: caseitem.status!,
                      ))),
                      DataCell(Center(
                          child: CustomText(
                              text: caseitem.createdAt!.toIso8601String()))),
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
                    ],
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
