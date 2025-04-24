import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Dialog editSubcatDialog(BuildContext context) {
  TextEditingController catnamecontroller =
      TextEditingController();

  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: cyan200),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 2.3,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'تعديل صنف فرعي',
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
                      height: 10,
                    ),
                    Text('أدخل الاسم الجديد'),
                    SizedBox(
                      width: 250,
                      child: defaultTextField(
                          catnamecontroller, context, ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                        text: 'تعديل',
                        function: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
          ])),
    ),
  );
}
