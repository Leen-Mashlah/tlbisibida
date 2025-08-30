import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/clients/dentist_payment.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';

/// Example without datasource
// ignore: must_be_immutable
class PaymentLogTable extends StatelessWidget {
  final int dentistId;

  const PaymentLogTable({
    super.key,
    required this.dentistId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        if (state is DentistPaymentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DentistPaymentsLoaded) {
          final payments = state.dentistPaymentsResponse.dentistPayments;
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
                  height: (56 * payments.length) + 40,
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
                    rows: payments
                        .map((payment) => DataRow(
                              cells: [
                                DataCell(Center(
                                    child: CustomText(
                                  text: '${payment.signedValue}',
                                ))),
                                DataCell(Center(
                                    child: CustomText(
                                        text: _formatDate(payment.createdAt)))),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ]),
            ),
          );
        } else if (state is DentistPaymentsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  'Error: ${state.message}',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context
                      .read<ClientsCubit>()
                      .getDentistPayments(dentistId),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          // Load payments when widget is first built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<ClientsCubit>().getDentistPayments(dentistId);
          });
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
