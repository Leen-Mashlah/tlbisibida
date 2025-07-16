import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';

/// Example without datasource
// ignore: must_be_immutable
class ClientsTable extends StatelessWidget {
  const ClientsTable({super.key});

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
            height: (56 * clientsCubit.labClients.length) + 40,
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
                    'اسم الزبون',
                    style: TextStyle(color: cyan300),
                  )),
                ),
                // DataColumn(
                //   label: Center(
                //       child: Text(
                //     'الرصيد',
                //     style: TextStyle(color: cyan300),
                //   )),
                // ),
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
                    'التفاصيل',
                    style: TextStyle(color: cyan300),
                  )),
                ),
              ],
              rows: List<DataRow>.generate(
                clientsCubit.labClients.length,
                (index) {
                  final client = clientsCubit.labClients[index];
                  return DataRow(
                  cells: [
                     DataCell(Center(
                        child: CustomText(
                      text: client.firstName,
                    ))),
                    //  DataCell(Center(child: CustomText(text: client..toString()))),
                     DataCell(
                        Center(child: CustomText(text:client.phone.toString()))),
                     DataCell(Center(child: CustomText(text: client.address))),
                     DataCell(
                        Center(child: CustomText(text: client.registerDate))),
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
