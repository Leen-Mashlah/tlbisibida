// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';

class BillPreviewDialog extends StatelessWidget {
  const BillPreviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: BlocBuilder<ClientsCubit, ClientsState>(
          builder: (context, state) {
            if (state is PreviewBillLoading) {
              return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()));
            }
            if (state is PreviewBillLoaded) {
              final preview = state.previewBillResponse.preview;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('مسودة الفاتورة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 600,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: preview.medicalCases.length,
                        separatorBuilder: (context, _) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final mc = preview.medicalCases[index];
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
                                  Text('${mc.id}',
                                      style: const TextStyle(
                                          fontSize: 18, color: cyan600),
                                      overflow: TextOverflow.ellipsis),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Patient: ${mc.patient.fullName}'),
                                      Text(
                                          'Date: ${mc.createdAt.substring(0, 10)}'),
                                    ],
                                  ),
                                  Text('Cost: ${mc.cost}'),
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
                            child: Text('${preview.totalBillCost}',
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text('المجموع', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        defaultButton(
                          text: 'إرسال',
                          function: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 5),
                        redButton(
                          text: 'إلغاء',
                          function: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            if (state is PreviewBillError) {
              return const SizedBox(
                  height: 200,
                  child: Center(child: Text('فشل في تحميل معاينة الفاتورة')));
            }
            return const SizedBox(
                height: 200, child: Center(child: Text('لا توجد بيانات')));
          },
        ),
      ),
    );
  }
}
