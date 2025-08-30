import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';

/// Example without datasource
// ignore: must_be_immutable
class ClientsTable extends StatelessWidget {
  const ClientsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(builder: (context, state) {
      final clientsCubit = context.read<ClientsCubit>();

      if (state is ClientsLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ClientsError) {
        return const Center(child: Text('حدث خطأ أثناء تحميل الزبائن'));
      }

      final clients = clientsCubit.clientsResponse?.clients ?? [];

      if (clients.isEmpty) {
        return const Center(child: Text('لا يوجد زبائن مسجلين'));
      }

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
              height: (56 * clients.length) + 40,
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
                  clients.length,
                  (index) {
                    final client = clients[index];
                    return DataRow(
                      cells: [
                        DataCell(Center(
                            child: CustomText(
                          text: client.name,
                        ))),
                        DataCell(Center(
                            child: CustomText(text: client.phone.toString()))),
                        DataCell(
                            Center(child: CustomText(text: client.address))),
                        DataCell(
                            Center(child: CustomText(text: client.joinedOn))),
                        DataCell(Center(
                            child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/client_details',
                              arguments: {
                                'id': client.id,
                                'name': client.name,
                                'phone': client.phone,
                                'address': client.address,
                              },
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
    });
  }
}
