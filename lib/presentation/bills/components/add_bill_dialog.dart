import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/pages/search_for_lab.dart';

class AddBillDialog extends StatelessWidget {
  AddBillDialog({
    super.key,
  });
  DateTime birthdate = DateTime.now();
  final List<String> _labslist = [
    ' الحموي',
    ' الحمصي',
    ' الشامي',
    ' التحسيني',
  ];
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
                'إضافة فاتورة',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: cyan200,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceButtonWithSearch(
                              names: _labslist,
                              hintText:
                                  'اختر الزبون', // Example hint text in Arabic
                              onNameSelected: (selectedName) {
                                print('Selected: $selectedName');
                                // Do something with the selected name
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          // const Text(
                          //   'رصيد الزبون',
                          //   style: TextStyle(fontSize: 18),
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // const Text(
                          //   '5.000.000',
                          //   style: TextStyle(
                          //       color: Colors.redAccent,
                          //       fontSize: 18,
                          //       decoration: TextDecoration.underline,
                          //       decorationColor: Colors.redAccent,
                          //       decorationThickness: .5),
                          // ),
                          // const SizedBox(
                          //   height: 30,
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
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
                                'بداية الفاتورة',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
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
                                'نهاية الفاتورة',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'الفاتورة النهائية',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: cyan200,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          child: Text(
                            '3.000.000',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              defaultButton(
                  text: 'إرسال',
                  function: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
