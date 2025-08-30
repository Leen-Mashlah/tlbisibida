import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/payments_cubit.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/payments_state.dart';

/// Example without datasource
// ignore: must_be_immutable
class OpPaymentsLogTable extends StatelessWidget {
  final PaymentsCubit cubit;

  const OpPaymentsLogTable({super.key, required this.cubit});

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
            bloc: cubit,
            builder: (context, state) {
              final items = (state is PaymentsOpLoaded)
                  ? state.operatingItems
                  : cubit.operatingItems;
              final rowCount = items.isEmpty ? 1 : items.length;
              return SizedBox(
                height: (56 * rowCount) + 40,
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
                        'المبلغ المضاف',
                        style: TextStyle(color: cyan300),
                      )),
                    ),
                    DataColumn(
                      label: Center(
                          child: Text(
                        'تاريخ الدفع',
                        style: TextStyle(color: cyan300),
                      )),
                    ),
                  ],
                  rows: items.isEmpty
                      ? [
                          const DataRow(cells: [
                            DataCell(Center(child: CustomText(text: '-'))),
                            DataCell(Center(child: CustomText(text: '-'))),
                          ])
                        ]
                      : items
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(Center(
                                  child: CustomText(text: e.value.toString()))),
                              DataCell(
                                  Center(child: CustomText(text: e.createdAt))),
                            ]),
                          )
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
