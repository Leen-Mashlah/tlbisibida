// ignore_for_file: prefer_const_constructors

import 'package:choice/choice.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/components/image_picker.dart';
import 'package:lambda_dent_dash/components/image_picker_profile.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class Register2Page extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final List _labtypes = ['تعويض', 'تقويم', 'بدلات'];
  final List _subsicribe = ['سنوي', 'نصف سنوي', 'ربع سنوي'];
  final ValueNotifier<List<String>> _targetlabtype =
      ValueNotifier<List<String>>([
    'تعويض',
  ]);
  final ValueNotifier<String> _subtype = ValueNotifier('سنوي');
  final List<String> provincesList = [
    'دمشق',
    'ريف دمشق',
    'القنيطرة',
    'درعا',
    'السويداء',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'حلب',
    'إدلب',
    'الرقة',
    'دير الزور',
    'الحسكة',
  ];
  List<Image> images = [];

  String selectedProvince = 'دمشق';

  Register2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/teeth_pattern.png',
                ),

                // fit: BoxFit.,
                repeat: ImageRepeat.repeat),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cyan200,
                  cyan100,
                  cyan50,
                  Color.fromARGB(149, 229, 243, 241),
                  cyan50,
                  cyan100,
                  cyan200
                ])),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(10),
                    ),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(200, 20, 112, 103),
                          Color.fromARGB(175, 41, 157, 144),
                          Color.fromARGB(175, 41, 157, 144),
                          Color.fromARGB(161, 51, 187, 171),
                          Color.fromARGB(175, 41, 157, 144),
                          Color.fromARGB(175, 41, 157, 144),
                          Color.fromARGB(200, 20, 112, 103),
                        ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 62),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: Image(
                            image: AssetImage(
                          "assets/logo_v2.png",
                        )),
                      ),
                      const Text(
                        'متابعة إنشاء حساب',
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                  color: Colors.black54,
                                  blurRadius: 8,
                                  offset: Offset(1, 1))
                            ],
                            fontSize: 30,
                            color: cyan50,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: cyan50op,
                            borderRadius: BorderRadius.circular(20)),
                        width: 500,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'اختر الاختصاص',
                              style: TextStyle(color: cyan500, fontSize: 16),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: InlineChoice<String>.multiple(
                                  value: _targetlabtype.value,
                                  onChanged: (obj) {
                                    _targetlabtype.value = obj;
                                    // print(_targetlabtype.toString());
                                  },
                                  clearable: false,
                                  itemCount: _labtypes.length,
                                  itemBuilder: (state, i) {
                                    return ChoiceChip(
                                      selectedColor: cyan200,
                                      side: const BorderSide(color: cyan300),
                                      selected: state.selected(_labtypes[i]),
                                      onSelected:
                                          state.onSelected(_labtypes[i]),
                                      label: Text(_labtypes[i]),
                                    );
                                  },
                                  listBuilder: ChoiceList.createWrapped(
                                      runAlignment: WrapAlignment.center,
                                      alignment: WrapAlignment.center,
                                      direction: Axis.horizontal,
                                      textDirection: TextDirection.rtl,
                                      //spacing: 10,
                                      //runSpacing: 10,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 5,
                                      ))),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: cyan50op,
                            borderRadius: BorderRadius.circular(20)),
                        width: 500,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'أوقات الدوام',
                              style: TextStyle(color: cyan500, fontSize: 14),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('من'),
                                  CupertinoTimePickerButton(
                                    mainColor: cyan400,
                                    initialTime:
                                        const TimeOfDay(hour: 9, minute: 41),
                                    onTimeChanged: (time) {},
                                  ),
                                  Text('إلى'),
                                  CupertinoTimePickerButton(
                                    mainColor: cyan400,
                                    initialTime:
                                        const TimeOfDay(hour: 19, minute: 41),
                                    onTimeChanged: (time) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: cyan50op,
                            borderRadius: BorderRadius.circular(30)),
                        width: 500,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اختر صورة الملف الشخصي',
                                style: TextStyle(color: cyan600, fontSize: 14),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 38.0),
                                child: imagePickerPro(images),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: cyan50op,
                            borderRadius: BorderRadius.circular(20)),
                        width: 500,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'اختر الاشتراك',
                              style: TextStyle(color: cyan500, fontSize: 16),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: InlineChoice<String>.single(
                                  value: _subtype.value,
                                  onChanged: (obj) {
                                    _subtype.value = obj!;
                                    // print(_targetlabtype.toString());
                                  },
                                  clearable: false,
                                  itemCount: _subsicribe.length,
                                  itemBuilder: (state, i) {
                                    return ChoiceChip(
                                      selectedColor: cyan200,
                                      side: const BorderSide(color: cyan300),
                                      selected: state.selected(_subsicribe[i]),
                                      onSelected:
                                          state.onSelected(_subsicribe[i]),
                                      label: Text(_subsicribe[i]),
                                    );
                                  },
                                  listBuilder: ChoiceList.createWrapped(
                                      runAlignment: WrapAlignment.center,
                                      alignment: WrapAlignment.center,
                                      direction: Axis.horizontal,
                                      textDirection: TextDirection.rtl,
                                      //spacing: 10,
                                      //runSpacing: 10,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 5,
                                      ))),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // onTap: adminAuth.isLoading.value
                          //     ? null
                          //     : ()async {
                          //         adminAuth.admin_login(email.text, password.text);
                          //          Get.offNamed("Employees");

                          //       },
                        },
                        style: ButtonStyle(
                            shadowColor: const WidgetStatePropertyAll(cyan200),
                            backgroundColor:
                                const WidgetStatePropertyAll(cyan200),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 60),
                            ),
                            elevation: const WidgetStatePropertyAll(5),
                            backgroundBuilder: (context, states, child) {
                              return Container(
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [cyan200, cyan50, cyan200])),
                                child: child,
                              );
                            },
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: const BorderSide(color: cyan500),
                                    borderRadius: BorderRadius.circular(15)))),
                        child: const CustomText(
                            //  adminAuth.isLoading.value
                            //     ? CircularProgressIndicator(
                            //         valueColor:
                            //             AlwaysStoppedAnimation<Color>(Colors.white))
                            //
                            text: "إنشاء حساب",
                            color: cyan500),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Checkbox(value: true, onChanged: (value) {}),
                  //         const CustomText(
                  //           text: "Remeber Me",
                  //         ),
                  //       ],
                  //     ),
                  //     const CustomText(text: "Forgot password?", color: cyan400)
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(right: 12),
                  //   child: Image.asset(
                  //     "assets/logo_v2.png",
                  //     width: 250,
                  //     height: 250,
                  //   ),
                  // ),
                  // Expanded(child: Container()),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Row(
                  //   children: [
                  //     Text("Login",
                  //         style: TextStyle(
                  //             fontSize: 30, fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   children: [
                  //     CustomText(
                  //       text: "Welcome back to the admin panel.",
                  //       color: Colors.grey[300],
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // // TextField(
                  // //   controller: email,
                  // //   decoration: InputDecoration(
                  // //       labelText: "Email",
                  // //       hintText: "abc@domain.com",
                  // //       border: OutlineInputBorder(
                  // //           borderRadius: BorderRadius.circular(20))),
                  // // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // // TextField(
                  // //   controller: password,
                  // //   obscureText: true,
                  // //   decoration: InputDecoration(
                  // //       labelText: "Password",
                  // //       hintText: "123",
                  // //       border: OutlineInputBorder(
                  // //           borderRadius: BorderRadius.circular(20))),
                  // // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Checkbox(value: true, onChanged: (value) {}),
                  //         const CustomText(
                  //           text: "Remeber Me",
                  //         ),
                  //       ],
                  //     ),
                  //     const CustomText(text: "Forgot password?", color: cyan400)
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // // InkWell(
                  // //   // onTap: adminAuth.isLoading.value
                  // //   //     ? null
                  // //   //     : ()async {
                  // //   //         adminAuth.admin_login(email.text, password.text);
                  // //   //          Get.offNamed("Employees");

                  // //   //       },
                  // //   child: Container(
                  // //     decoration: BoxDecoration(
                  // //         color: cyan400,
                  // //         borderRadius: BorderRadius.circular(20)),
                  // //     alignment: Alignment.center,
                  // //     // width: double.maxFinite,
                  // //     padding: const EdgeInsets.symmetric(vertical: 16),
                  // //     child:
                  // //         //  adminAuth.isLoading.value
                  // //         //     ? CircularProgressIndicator(
                  // //         //         valueColor:
                  // //         //             AlwaysStoppedAnimation<Color>(Colors.white))
                  // //         //     :
                  // //         const CustomText(
                  // //       text: "Login",
                  // //       color: Colors.white,
                  // //     ),
                  // //   ),
                  // // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // RichText(
                  //     text: const TextSpan(children: [
                  //   TextSpan(text: "Do not have admin credentials? "),
                  //   TextSpan(
                  //       text: "Request Credentials! ",
                  //       style: TextStyle(color: cyan400))
                  // ]))
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
