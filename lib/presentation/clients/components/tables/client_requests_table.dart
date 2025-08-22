import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/components/dialogs/confirm_add_dialog%20.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';

/// Example without datasource
// ignore: must_be_immutable
class ClientsReqTable extends StatelessWidget {
  const ClientsReqTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(builder: (context, state) {
      final cubit = context.read<ClientsCubit>();
      final requests = cubit.joinRequestsResponse?.joinRequests ?? [];

      if (state is RequestsLoading && requests.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ClientsError && requests.isEmpty) {
        return const Center(child: Text('حدث خطأ أثناء تحميل الطلبات'));
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
              height: (56 * requests.length) + 40,
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
                      'اسم الطبيب',
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
                      'تاريخ إرسال الطلب',
                      style: TextStyle(color: cyan300),
                    )),
                  ),
                  DataColumn(
                    label: Center(
                        child: Text(
                      'تأكيد الإضافة',
                      style: TextStyle(color: cyan300),
                    )),
                  ),
                ],
                rows: List<DataRow>.generate(
                  requests.length,
                  (index) {
                    final req = requests[index];
                    return DataRow(
                      cells: [
                        DataCell(Center(child: CustomText(text: req.name))),
                        DataCell(Center(
                            child: CustomText(text: req.phone.toString()))),
                        DataCell(Center(child: CustomText(text: req.address))),
                        DataCell(
                            Center(child: CustomText(text: req.requestDate))),
                        DataCell(Center(
                            child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return confirmAddDialog(
                                      context, req.id, cubit);
                                });
                          },
                          icon: const Icon(
                            Icons.check_circle_outline,
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
