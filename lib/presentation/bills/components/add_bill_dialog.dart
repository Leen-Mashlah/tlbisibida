import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/lab_clients/lab_client.dart';
import 'package:lambda_dent_dash/presentation/bills/components/bill_preview_dialog.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/search_for_client.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';

class AddBillDialog extends StatefulWidget {
  AddBillDialog({super.key, required this.clientsCubit});

  final ClientsCubit clientsCubit;

  @override
  State<AddBillDialog> createState() => _AddBillDialogState();
}

class _AddBillDialogState extends State<AddBillDialog> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int? selectedDentistId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.clientsCubit,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('إضافة فاتورة', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: cyan200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChoiceButtonWithSearch(
                              hintText: 'اختر الزبون',
                              clientsCubit: widget.clientsCubit,
                              onClientSelected: (client) {
                                selectedDentistId = client.id;
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 30),
                                GestureDetector(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: fromDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050),
                                    );
                                    if (picked != null)
                                      setState(() => fromDate = picked);
                                  },
                                  child: datePicker(context, fromDate),
                                ),
                                const SizedBox(width: 30),
                                const Text('بداية الفاتورة',
                                    style: TextStyle(fontSize: 18)),
                                const SizedBox(width: 30),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 30),
                                GestureDetector(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: toDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050),
                                    );
                                    if (picked != null)
                                      setState(() => toDate = picked);
                                  },
                                  child: datePicker(context, toDate),
                                ),
                                const SizedBox(width: 30),
                                const Text('نهاية الفاتورة',
                                    style: TextStyle(fontSize: 18)),
                                const SizedBox(width: 30),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text('الفاتورة النهائية',
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: cyan200, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            child: Text('—', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                defaultButton(
                  text: 'معاينة',
                  function: () async {
                    if (selectedDentistId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يرجى اختيار الزبون')),
                      );
                      return;
                    }
                    final dateFrom = _fmt(fromDate);
                    final dateTo = _fmt(toDate);
                    await widget.clientsCubit.previewBill(
                      dentistId: selectedDentistId!,
                      dateFrom: dateFrom,
                      dateTo: dateTo,
                    );
                    if (!mounted) return;
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => BillPreviewDialog(
                        clientsCubit: widget.clientsCubit,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
