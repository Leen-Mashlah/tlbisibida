// ignore_for_file: prefer_const_constructors

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:choice/choice.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/components/image_picker_profile.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_state.dart';

class Register2Page extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  final List _labtypes = ['تعويض', 'تقويم', 'بدلات'];
  final ValueNotifier<List<String>> _targetlabtype =
      ValueNotifier<List<String>>([
    'تعويض',
  ]);
  final List<int> _subsicribe = [12, 6, 3];
  final ValueNotifier<int> _subtype = ValueNotifier<int>(12);
  List<Image> images = [];

  Register2Page({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    // Initialize default time values if user hasn't interacted yet
    if (startTime.text.isEmpty) {
      const def = TimeOfDay(hour: 9, minute: 0);
      final hh = def.hour.toString().padLeft(2, '0');
      final mm = def.minute.toString().padLeft(2, '0');
      startTime.text = '$hh:$mm';
    }
    if (endTime.text.isEmpty) {
      const def = TimeOfDay(hour: 21, minute: 0);
      final hh = def.hour.toString().padLeft(2, '0');
      final mm = def.minute.toString().padLeft(2, '0');
      endTime.text = '$hh:$mm';
    }
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistered) {
            AnimatedSnackBar.material(
              'تم تسجيل طلبك بنجاح!',
              type: AnimatedSnackBarType.success,
              desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
              duration: Duration(seconds: 3),
              animationCurve: Easing.standard,
            ).show(context);
            locator<NavigationService>().navigateTo(emailVerificationPageRoute);
          } else if (state is AuthError) {
            AnimatedSnackBar.material(
              'لم يتم تسجيل الطلب ـ تأكد من المعلومات المدخلة ثم حاول مرة أخرى',
              type: AnimatedSnackBarType.error,
              desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
              duration: Duration(seconds: 3),
              animationCurve: Easing.standard,
            ).show(context);
          }
        },
        builder: (context, state) {
          return Container(
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
                                  style:
                                      TextStyle(color: cyan500, fontSize: 16),
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
                                          side:
                                              const BorderSide(color: cyan300),
                                          selected:
                                              state.selected(_labtypes[i]),
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
                                  style:
                                      TextStyle(color: cyan500, fontSize: 14),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('من'),
                                      CupertinoTimePickerButton(
                                        mainColor: cyan400,
                                        initialTime: const TimeOfDay(
                                            hour: 9, minute: 00),
                                        onTimeChanged: (time) {
                                          final hh = time.hour
                                              .toString()
                                              .padLeft(2, '0');
                                          final mm = time.minute
                                              .toString()
                                              .padLeft(2, '0');
                                          startTime.text = '$hh:$mm';
                                        },
                                      ),
                                      Text('إلى'),
                                      CupertinoTimePickerButton(
                                        mainColor: cyan400,
                                        initialTime: const TimeOfDay(
                                            hour: 21, minute: 00),
                                        onTimeChanged: (time) {
                                          final hh = time.hour
                                              .toString()
                                              .padLeft(2, '0');
                                          final mm = time.minute
                                              .toString()
                                              .padLeft(2, '0');
                                          endTime.text = '$hh:$mm';
                                        },
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'اختر صورة الملف الشخصي',
                                    style:
                                        TextStyle(color: cyan600, fontSize: 14),
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
                                  style:
                                      TextStyle(color: cyan500, fontSize: 16),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: InlineChoice<int>.single(
                                      value: _subtype.value,
                                      onChanged: (obj) {
                                        if (obj != null) _subtype.value = obj;
                                        // print(_targetlabtype.toString());
                                      },
                                      clearable: false,
                                      itemCount: _subsicribe.length,
                                      itemBuilder: (state, i) {
                                        return ChoiceChip(
                                          selectedColor: cyan200,
                                          side:
                                              const BorderSide(color: cyan300),
                                          selected:
                                              state.selected(_subsicribe[i]),
                                          onSelected:
                                              state.onSelected(_subsicribe[i]),
                                          label: Text(
                                            _subsicribe[i] == 12
                                                ? 'سنوي'
                                                : _subsicribe[i] == 6
                                                    ? 'نصف سنوي'
                                                    : 'ربع سنوي',
                                          ),
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
                              final start = startTime.text.isEmpty
                                  ? '09:00'
                                  : startTime.text;
                              final end =
                                  endTime.text.isEmpty ? '21:00' : endTime.text;
                              cubit.cookregistrysecond(
                                  labType: _targetlabtype.value[0],
                                  startHour: start,
                                  endHour: end,
                                  subscriptionDuration: _subtype.value);
                            },
                            style: ButtonStyle(
                                shadowColor:
                                    const WidgetStatePropertyAll(cyan200),
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
                                            colors: [
                                          cyan200,
                                          cyan50,
                                          cyan200
                                        ])),
                                    child: child,
                                  );
                                },
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        side: const BorderSide(color: cyan500),
                                        borderRadius:
                                            BorderRadius.circular(15)))),
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
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
