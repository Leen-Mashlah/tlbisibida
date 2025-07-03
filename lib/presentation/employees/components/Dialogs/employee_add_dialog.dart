// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Dialog employeeAddDialog(BuildContext context) {
  TextEditingController employeenamecontroller =
      TextEditingController(text: 'تحسين التحسيني');
  TextEditingController employeeaddresscontroller =
      TextEditingController(text: 'absabsabsabsabs@gmail.com');
  TextEditingController employeephonecontroller =
      TextEditingController(text: '0933225511');
  DateTime startdate = DateTime.now();

  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: cyan200),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 1.5,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'إضافة موظف',
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
                    defaultTextField(
                      employeenamecontroller,
                      context,
                      'اسم الموظف',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                      employeeaddresscontroller,
                      context,
                      'البريد الالكتروني',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                      employeephonecontroller,
                      context,
                      'رقم الهاتف',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: true,
                                groupValue: 'groupValue',
                                onChanged: (value) {}),
                            Text(
                              'مدير شؤون مالية',
                              style: TextStyle(color: cyan600, fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: true,
                                groupValue: 'groupValue',
                                onChanged: (value) {}),
                            Text(
                              'مدير مخزن',
                              style: TextStyle(color: cyan600, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //width: 250,
                      children: [
                        Text(
                          'تاريخ بدء العمل',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        datePicker(context, startdate)
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
