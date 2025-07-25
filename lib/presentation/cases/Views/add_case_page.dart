// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/components/image_picker.dart';
import 'package:lambda_dent_dash/components/teeth_selection_screen.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/shade_guides/guide_button.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/search_for_lab.dart';

class AddCasePage extends StatelessWidget {
  final List<String> _labslist = [
    ' الحموي',
    ' الحمصي',
    ' الشامي',
    ' التحسيني',
  ];
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
  List<Image> images = [];

  var patientnamecontroller = TextEditingController(text: 'تحسين التحسيني');
  var docnamecontroller = TextEditingController(text: 'تحسين التحسيني');
  String? selectedLabName;
  var agecontroller = TextEditingController(text: '45');
  var notecontroller = TextEditingController(
      text:
          'الرجاء خفض التعويض لعدم وجود مسافة كافية وتضييق الفراغ بين السن والتعويض لضعف السن');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 5,
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
                    colors: const [cyan200, cyan400, cyan200],
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                      defaultTextField(notecontroller, context, 'ملاحظات',
                          inactiveColor: cyan100,
                          prefixIcon: Icon(Icons.edit_note),
                          height: 5,
                          maxLines: 5),
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
                      imagePicker(images),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 5,
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
                    colors: const [cyan200, cyan400, cyan200],
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ChoiceButtonWithSearch(
                          names: _labslist,
                          hintText:
                              'اختر الزبون', // Example hint text in Arabic
                          onNameSelected: (selectedName) {
                            print('Selected: $selectedName');
                            // Do something with the selected name
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        //width: 250,
                        child: defaultTextField(
                            patientNameController, context, 'اسم المريض',
                            inactiveColor: cyan100),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        //width: 300,
                        child: defaultTextField(
                            phoneNumberController, context, 'رقم الهاتف',
                            inactiveColor: cyan100),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                                height: 15,
                              ),
                              Container(
                                color: cyan200,
                                width: 150,
                                height: .5,
                              ),
                              SizedBox(
                                height: 15,
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
                    ]),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 5,
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
                    colors: const [cyan200, cyan500, cyan200],
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16),
                child: SizedBox(
                  child: TeethSelectionScreen(
                    asset: 'assets/teeth.svg',
                    isDocSheet: false,
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
