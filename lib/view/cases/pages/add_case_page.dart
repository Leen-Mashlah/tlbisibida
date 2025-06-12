// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/components/image_picker.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/cases/components/shade_guides/guide_button.dart';

class AddCasePage extends StatelessWidget {
  AddCasePage({super.key});
  bool v = true;
  DateTime birthdate = DateTime.now();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  bool _needTrial = false;
  bool _isRepeat = false;
  // ignore: unused_field
  String _toothshade = '';
  List _labtypes = ['تعويض', 'تقويم', 'بدلات'];
  final ValueNotifier<List<String>> _targetlabtype =
      ValueNotifier<List<String>>([
    'تعويض',
  ]);
  DateTime expectedDeliveryDate = DateTime.now();
  List<Uint8List> images = [];

  var patientnamecontroller = TextEditingController(text: 'تحسين التحسيني');
  String? selectedLabName;
  var agecontroller = TextEditingController(text: '45');
  var notecontroller = TextEditingController(
      text:
          'الرجاء خفض التعويض لعدم وجود مسافة كافية وتضييق الفراغ بين السن والتعويض لضعف السن');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: cyan100,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: cyan200, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          //width: 250,
                          child: defaultTextField(
                              patientNameController, context, 'اسم المريض'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          //width: 300,
                          child: defaultTextField(
                              phoneNumberController, context, 'رقم الهاتف'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //width: 250,
                          children: [
                            Text(
                              'المواليد',
                              style: TextStyle(color: cyan600, fontSize: 16),
                            ),
                            datePicker(context, birthdate)
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: cyan50,
                          ),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'ذكر',
                                        style: TextStyle(
                                            color: cyan600, fontSize: 16),
                                      ),
                                      Radio(
                                          value: true,
                                          groupValue: 'groupValue',
                                          onChanged: (value) {}),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'أنثى',
                                        style: TextStyle(
                                            color: cyan600, fontSize: 16),
                                      ),
                                      Radio(
                                          value: true,
                                          groupValue: 'groupValue',
                                          onChanged: (value) {}),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'مدخن؟',
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Checkbox(
                                    value: v,
                                    onChanged: (value) {
                                      value = !v;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ShadeSelectionButton(),
                            Container(
                              width: .5,
                              height: 100,
                              color: cyan300,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: _isRepeat,
                                      onChanged: (value) {
                                        value = !_isRepeat;
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    const Text('إعادة؟'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: _needTrial,
                                      onChanged: (value) {
                                        value = !_needTrial;
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    const Text('بحاجة تجربة؟'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          color: cyan300,
                          width: 200,
                          height: .5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'موعد التسليم:',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            datePicker(context, expectedDeliveryDate),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          color: cyan300,
                          width: 200,
                          height: .5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        imagePicker(images.cast<Image>()),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          color: cyan300,
                          width: 200,
                          height: .5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                          notecontroller,
                          context,
                          'ملاحظات',
                          prefixIcon: Icon(Icons.edit_note),
                          // height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
