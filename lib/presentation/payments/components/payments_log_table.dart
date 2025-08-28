import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/payments_cubit.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/payments_state.dart';

/// Example without datasource
// ignore: must_be_immutable
class PaymentsLogTable extends StatelessWidget {
  const PaymentsLogTable({super.key});

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
          BlocBuilder<PaymentsCubit, PaymentsState>(
            builder: (context, state) {
              final rows = state is PaymentsLoaded ? state.labItemsHistory : [];
              final count = rows.isEmpty ? 1 : rows.length;
              return SizedBox(
                height: (56 * count) + 40,
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
                        'اسم العنصر',
                        style: TextStyle(color: cyan300),
                      )),
                    ),
                    DataColumn(
                      label: Center(
                          child: Text(
                        'العدد/الكمية',
                        style: TextStyle(color: cyan300),
                      )),
                    ),
                    DataColumn(
                      label: Center(
                          child: Text(
                        'سعر العنصر الواحد',
                        style: TextStyle(color: cyan300),
                      )),
                    ),
                    DataColumn(
                      label: Center(
                          child: Text(
                        'المجموع',
                        style: TextStyle(color: cyan300),
                      )),
                    ),
                    DataColumn(
                      label: Center(
                          child: Text(
                        'تاريخ الشراء',
                        style: TextStyle(color: cyan300),
                      )),
                    ),
                  ],
                  rows: rows.isEmpty
                      ? const [
                          DataRow(cells: [
                            DataCell(Center(child: CustomText(text: '-'))),
                            DataCell(Center(child: CustomText(text: '-'))),
                            DataCell(Center(child: CustomText(text: '-'))),
                            DataCell(Center(child: CustomText(text: '-'))),
                            DataCell(Center(child: CustomText(text: '-'))),
                          ])
                        ]
                      : rows
                          .map((e) => DataRow(cells: [
                                DataCell(Center(
                                    child: CustomText(text: e.itemName))),
                                DataCell(Center(
                                    child: CustomText(
                                        text: e.quantity.toString()))),
                                DataCell(Center(
                                    child: CustomText(
                                        text: e.unitPrice.toString()))),
                                DataCell(Center(
                                    child: CustomText(
                                        text: e.totalPrice.toString()))),
                                DataCell(Center(
                                    child: CustomText(text: e.createdAt))),
                              ]))
                          .toList(),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
