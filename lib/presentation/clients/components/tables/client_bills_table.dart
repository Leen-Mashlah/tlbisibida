import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';
import 'package:lambda_dent_dash/presentation/bills/components/bill_details_dialog.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';

/// Example without datasource
// ignore: must_be_immutable
class ClientBillsTable extends StatelessWidget {
  const ClientBillsTable({super.key});

  @override
  Widget build(BuildContext context) {
    ClientsCubit clientsCubit = context.read<ClientsCubit>();

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
            height: (56 * clientsCubit.dentistBillsList!.bills.length) + 40,
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
                    'رقم الفاتورة',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: Text(
                    'تاريخ الفاتورة',
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
                clientsCubit.dentistBillsList!.bills.length,
                (index) {
                  DentistBillInList bill =
                      clientsCubit.dentistBillsList!.bills[index];
                  return DataRow(
                    cells: [
                      DataCell(Center(
                          child: CustomText(
                        text: bill.billNumber,
                      ))),
                      DataCell(Center(
                          child: CustomText(
                              text: bill.createdAt.toIso8601String()))),
                      DataCell(Center(
                          child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const BillDetailsDialog(),
                          );
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
