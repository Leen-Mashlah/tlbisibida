// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/bills/Cubits/bills_cubit.dart';
import 'package:lambda_dent_dash/presentation/bills/Cubits/bills_state.dart';

class BillDetailsDialog extends StatelessWidget {
  const BillDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: BlocBuilder<BillsCubit, BillsState>(
          builder: (context, state) {
            if (state is BillDetailsLoading) {
              return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()));
            }
            if (state is BillDetailsLoaded) {
              final details = state.billDetails;
              final bill =
                  details.data.bill.isNotEmpty ? details.data.bill.first : null;
              final cases = details.data.billCases;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('تفاصيل الفاتورة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 600,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cases.length,
                        separatorBuilder: (context, _) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final c = cases[index];
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: .5, color: cyan200)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('${c.medicalCase.id}',
                                      style: const TextStyle(
                                          fontSize: 18, color: cyan600),
                                      overflow: TextOverflow.ellipsis),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'المريض: ${c.medicalCase.patient.fullName}'),
                                      Text(
                                          'التاريخ: ${c.medicalCase.createdAt.substring(0, 10)}'),
                                    ],
                                  ),
                                  Text('التكلفة: ${c.caseCost}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: cyan200, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            child: Text('${bill?.totalCost ?? 0}',
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text('الفاتورة النهائية',
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    defaultButton(
                      text: 'تم',
                      function: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is BillDetailsError) {
              return const SizedBox(
                  height: 200,
                  child: Center(child: Text('فشل في تحميل تفاصيل الفاتورة')));
            }
            return const SizedBox(
                height: 200, child: Center(child: Text('لا توجد بيانات')));
          },
        ),
      ),
    );
  }
}
