import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/components/tables/payment_log_table.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';

Widget paymentLogDialog(BuildContext context,
    {required int dentistId, required ClientsCubit clientsCubit}) {
  TextEditingController valueController = TextEditingController();
  TextEditingController confirmValueController = TextEditingController();

  return BlocProvider.value(
    value: clientsCubit,
    child: Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: cyan200),
                borderRadius: BorderRadius.circular(20)),
            width: 1200, // MediaQuery.of(context).size.width / 4,
            height: 600, //MediaQuery.of(context).size.height / 1.3,
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: cyan200, width: .5),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 6),
                                color: Colors.grey,
                                blurRadius: 12)
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.all(30),
                        padding: EdgeInsets.all(30),
                        height: 500,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'إضافة دفعة',
                                style: TextStyle(
                                    color: cyan400,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: .5,
                                width: 100,
                                color: cyan200,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                              ),
                              const SizedBox(
                                height: 70,
                              ),
                              defaultTextField(
                                valueController,
                                context,
                                'القيمة المضافة',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              defaultTextField(confirmValueController, context,
                                  'تأكيد القيمة',
                                  keyboardType: TextInputType.number),
                              const SizedBox(
                                height: 70,
                              ),
                              BlocConsumer<ClientsCubit, ClientsState>(
                                listener: (context, state) {
                                  if (state is DentistPaymentsError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return defaultButton(
                                      text: state is DentistPaymentsLoading
                                          ? 'جاري الإضافة...'
                                          : 'إضافة',
                                      function: state is DentistPaymentsLoading
                                          ? () {}
                                          : () async {
                                              final value = int.tryParse(
                                                  valueController.text.trim());
                                              final confirmValue = int.tryParse(
                                                  confirmValueController.text
                                                      .trim());

                                              if (value == null ||
                                                  confirmValue == null) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'يرجى إدخال قيمة صحيحة')),
                                                );
                                                return;
                                              }

                                              if (value != confirmValue) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'القيمتان غير متطابقتين')),
                                                );
                                                return;
                                              }

                                              final success = await context
                                                  .read<ClientsCubit>()
                                                  .addDentistPayment(
                                                      dentistId, value);
                                              if (success) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'تم إضافة الدفعة بنجاح'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                              }
                                            });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                              width: 900,
                              height: 500,
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Text(
                                    'سجل الدفعات',
                                    style: TextStyle(
                                        color: cyan400,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  PaymentLogTable(dentistId: dentistId),
                                ],
                              ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])),
      ),
    ),
  );
}
