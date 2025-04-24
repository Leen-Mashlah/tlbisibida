import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Dialog addQuantityForItem(BuildContext context) {
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController itemstandardquantitycontroller =
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
                      'إضافة كمية',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('kg'),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: defaultTextField(
                            itemnamecontroller,
                            context,
                            'الكمية المضافة',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: defaultTextField(itemstandardquantitycontroller,
                          context, 'سعر الواحدة'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                        text: 'إضافة',
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
