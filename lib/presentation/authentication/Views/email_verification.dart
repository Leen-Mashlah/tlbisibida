import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/components/num_input.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/email_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/email_state.dart';

class EmailVerificationPage extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
  String email = 'abc@example.com';
  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();
  TextEditingController code5 = TextEditingController();
  TextEditingController code6 = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  String concatinateCode(List<TextEditingController> controllers) {
    String code = '';
    for (var controller in controllers) {
      code += controller.text;
    }
    return code;
  }

  EmailVerificationPage({required String email, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EmailCubit, EmailState>(
        listener: (context, state) {
          if (state is EmailChecked) {
            // handle verification success
          } else if (state is EmailError) {
            // handle error
          }
        },
        builder: (context, state) {
          EmailCubit cubit = context.read<EmailCubit>();
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
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width / 1.3,
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
                          vertical: 20.0, horizontal: 60),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Image.asset('icons/email-verify.png',
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.asset('assets/logo_v2.png')),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text('التحقق من البريد الإلكتروني',
                                    style: TextStyle(
                                      color: cyan50,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            color: Color.fromARGB(
                                                112, 125, 117, 117),
                                            blurRadius: 2,
                                            offset: Offset(-1, 2))
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox()),
                          Container(
                            height: 230,
                            width: .5,
                            color: cyan500,
                          ),
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                const Expanded(child: SizedBox()),
                                const Text(
                                  'أدخل رمز التحقق الذي تم إرساله إلى بريدك',
                                  style: TextStyle(
                                    color: cyan50,
                                    fontSize: 22,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black54,
                                          blurRadius: 8,
                                          offset: Offset(1, 1))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  email,
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black54,
                                          blurRadius: 8,
                                          offset: Offset(1, 1))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NumInput(context,
                                          controller: code1,
                                          focusNode: f1,
                                          nextFocus: f2),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      NumInput(context,
                                          controller: code2,
                                          focusNode: f2,
                                          nextFocus: f3),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      NumInput(context,
                                          controller: code3,
                                          focusNode: f3,
                                          nextFocus: f4),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      NumInput(context,
                                          controller: code4,
                                          focusNode: f4,
                                          nextFocus: f5),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      NumInput(context,
                                          controller: code5,
                                          focusNode: f5,
                                          nextFocus: f6),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      NumInput(context,
                                          controller: code6, focusNode: f6),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                    style: const ButtonStyle(
                                        shadowColor:
                                            WidgetStatePropertyAll(cyan400),
                                        overlayColor:
                                            WidgetStateColor.transparent),
                                    onPressed: () {},
                                    child: const Text(
                                      'إرسال الكود مرة أخرى',
                                      style: TextStyle(
                                        color: cyan50,
                                        fontSize: 16,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black54,
                                              blurRadius: 8,
                                              offset: Offset(1, 1))
                                        ],
                                      ),
                                    )),
                                // Expanded(child: SizedBox()),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    String code = concatinateCode([
                                      code1,
                                      code2,
                                      code3,
                                      code4,
                                      code5,
                                      code6
                                    ]);
                                    cubit.checkVerificationCode(
                                        'manager', email, int.parse(code));
                                    locator<NavigationService>()
                                        .navigateTo(homePageRoute);
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
                                      elevation:
                                          const WidgetStatePropertyAll(5),
                                      backgroundBuilder:
                                          (context, states, child) {
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
                                              side: const BorderSide(
                                                  color: cyan500),
                                              borderRadius:
                                                  BorderRadius.circular(15)))),
                                  child: const CustomText(
                                      //  adminAuth.isLoading.value
                                      //     ? CircularProgressIndicator(
                                      //         valueColor:
                                      //             AlwaysStoppedAnimation<Color>(Colors.white))
                                      //
                                      text: "التحقق",
                                      color: cyan500),
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
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
