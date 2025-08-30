import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';

/// Example without datasource
// ignore: must_be_immutable
class PaymentLogTable extends StatefulWidget {
  final int dentistId;

  const PaymentLogTable({
    super.key,
    required this.dentistId,
  });

  @override
  State<PaymentLogTable> createState() => _PaymentLogTableState();
}

class _PaymentLogTableState extends State<PaymentLogTable> {
  bool _hasLoadedData = false;

  @override
  void initState() {
    super.initState();
    // Load data only once when widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasLoadedData) {
        context.read<ClientsCubit>().getDentistPayments(widget.dentistId);
        _hasLoadedData = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        if (state is DentistPaymentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DentistPaymentsLoaded ||
            state is DentistPaymentAdded) {
          final payments = state is DentistPaymentsLoaded
              ? (state as DentistPaymentsLoaded)
                  .dentistPaymentsResponse
                  .dentistPayments
              : (state as DentistPaymentAdded)
                  .dentistPaymentsResponse
                  .dentistPayments;

          // Mark data as loaded when we receive it
          if (!_hasLoadedData) {
            _hasLoadedData = true;
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
        } else if (state is DentistPaymentsError ||
            state is DentistPaymentAddError) {
          final errorMessage = state is DentistPaymentsError
              ? (state as DentistPaymentsError).message
              : (state as DentistPaymentAddError).message;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  'Error: $errorMessage',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<ClientsCubit>()
                        .getDentistPayments(widget.dentistId);
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          // Show loading indicator if data hasn't been loaded yet
          if (!_hasLoadedData) {
            return const Center(child: CircularProgressIndicator());
          }

          // If we have loaded data but state doesn't match expected states,
          // show empty state or loading
          return const Center(
            child: Text('لا توجد بيانات متاحة'),
          );
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
