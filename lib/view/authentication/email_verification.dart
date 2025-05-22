import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/components/num_input.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class EmailVerificationPage extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
  String email = 'abc@example.com';
  TextEditingController codecontroller = TextEditingController();

  EmailVerificationPage({super.key});

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
            height: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width / 1.3,
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
                      vertical: 20.0, horizontal: 60),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset('icons/email-verify.png',
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset('assets/logo_v2.png')),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text('التحقق من البريد الإلكتروني',
                                style: TextStyle(
                                  color: cyan50,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: const Color.fromARGB(
                                            112, 125, 117, 117),
                                        blurRadius: 2,
                                        offset: Offset(-1, 2))
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      Container(
                        height: 230,
                        width: .5,
                        color: cyan500,
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(child: SizedBox()),
                            Text(
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
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              email,
                              style: TextStyle(
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
                            SizedBox(
                              height: 30,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumInput(context, controller: codecontroller),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  NumInput(context),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  NumInput(context),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  NumInput(context),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  NumInput(context),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  NumInput(context),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                    shadowColor:
                                        WidgetStatePropertyAll(cyan400),
                                    overlayColor: WidgetStateColor.transparent),
                                onPressed: () {},
                                child: Text(
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
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // onTap: adminAuth.isLoading.value
                                //     ? null
                                //     : ()async {
                                //         adminAuth.admin_login(email.text, password.text);
                                //          Get.offNamed("Employees");

                                //       },
                                locator<NavigationService>()
                                    .navigateTo(register2PageRoute);
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
                                          side:
                                              const BorderSide(color: cyan500),
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
                            Expanded(child: SizedBox()),
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
      ),
    );
  }
}
