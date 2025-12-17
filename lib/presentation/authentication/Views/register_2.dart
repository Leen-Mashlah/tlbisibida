import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:choice/choice.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/animated_snack_bar.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/components/image_picker_profile.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

import '../Cubits/auth_cubit.dart';
import '../Cubits/auth_state.dart';

class Register2Page extends StatelessWidget {
  Register2Page({super.key});

  final List _labtypes = ['تعويض', 'تقويم', 'بدلات'];
  final ValueNotifier<List<String>> _targetlabtype =
      ValueNotifier<List<String>>([
    'تعويض',
  ]);

  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  List<Image> images = [];

  final List<int> _subscription_length = [12, 6, 3];
  final ValueNotifier<int> _subtype = ValueNotifier<int>(12);

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
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
          if (state is AuthError) {
            showSnackBar(
              context,
              message: state.message,
              type: AnimatedSnackBarType.error,
            );
          }
          if (state is AuthRegistered) {
            showSnackBar(
              context,
              message: state.message,
              type: AnimatedSnackBarType.success,
            );
            locator<NavigationService>().navigateTo(emailVerificationPageRoute);
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(60),
                          bottomLeft: Radius.circular(10),
                        ),
                        gradient: LinearGradient(
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
                                const Text(
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
                                      const Text('من'),
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
                                      const Text('إلى'),
                                      CupertinoTimePickerButton(
                                        mainColor: cyan400,
                                        initialTime: const TimeOfDay(
                                            hour: 19, minute: 00),
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
                                  const Text(
                                    'اختر صورة الملف الشخصي',
                                    style:
                                        TextStyle(color: cyan600, fontSize: 14),
                                  ),
                                  const SizedBox(
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
                                const Text(
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
                                      itemCount: _subscription_length.length,
                                      itemBuilder: (state, i) {
                                        return ChoiceChip(
                                          selectedColor: cyan200,
                                          side:
                                              const BorderSide(color: cyan300),
                                          selected: state.selected(
                                              _subscription_length[i]),
                                          onSelected: state.onSelected(
                                              _subscription_length[i]),
                                          label: Text(
                                            _subscription_length[i] == 12
                                                ? 'سنوي'
                                                : _subscription_length[i] == 6
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
                            child: cubit.state is AuthLoading
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(cyan500))
                                : cubit.state is AuthRegistered
                                    ? const Icon(
                                        Icons.check_rounded,
                                        color: cyan500,
                                      )
                                    : const CustomText(
                                        text: "إنشاء حساب", color: cyan500),
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
