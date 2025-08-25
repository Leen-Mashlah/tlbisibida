import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/op_payments_cubit.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/op_payments_state.dart';

class AddConstantPaymentDialog extends StatelessWidget {
  AddConstantPaymentDialog({
    super.key,
  });
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController confirmCostController = TextEditingController();
  DateTime birthdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'إضافة مدفوعات ثابتة',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: Container(
                  width: 600,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: cyan200,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultTextField(
                              titleController, context, 'عنوان المدفوعات'),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              nameController, context, 'اسم المصروف'),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              costController, context, 'القيمة المدفوعة'),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              confirmCostController, context, 'تأكيد القيمة'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          datePicker(context, birthdate),
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            'تاريخ الدفع',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<OperatingPaymentsCubit, OperatingPaymentsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  final isSubmitting = state is OperatingPaymentsSubmitting;
                  return defaultButton(
                      text: isSubmitting ? '...جاري الإرسال' : 'إرسال',
                      function: () {
                        if (isSubmitting) return;
                        final name = nameController.text.trim();
                        final value = costController.text.trim();
                        final confirm = confirmCostController.text.trim();
                        if (name.isEmpty ||
                            value.isEmpty ||
                            confirm.isEmpty ||
                            value != confirm) {
                          return;
                        }
                        () async {
                          final ok = await context
                              .read<OperatingPaymentsCubit>()
                              .addOperatingPayment(name: name, value: value);
                          if (ok) {
                            Navigator.pop(context);
                          }
                        }();
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
