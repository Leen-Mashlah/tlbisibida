import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class RegisterPage extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RegisterPage({super.key});

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
                      vertical: 20.0, horizontal: 62),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 200,
                        height: 200,
                        child: Image(
                            image: AssetImage(
                          "assets/logo_v2.png",
                        )),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        'التسجيل',
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
                      Expanded(
                        child: Container(),
                      ),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "اسم المخبر",
                          labelStyle: const TextStyle(color: white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: cyan200,
                                width: 2,
                              )),
                          // hintText: "abc@domain.com",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cyan50,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "اسم المدير",
                          labelStyle: const TextStyle(color: white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: cyan200,
                                width: 2,
                              )),
                          // hintText: "abc@domain.com",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cyan50,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "اسم المخبر",
                          labelStyle: const TextStyle(color: white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: cyan200,
                                width: 2,
                              )),
                          // hintText: "abc@domain.com",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cyan50,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "البريد الالكتروني",
                          labelStyle: const TextStyle(color: white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: cyan200,
                                width: 2,
                              )),
                          // hintText: "abc@domain.com",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cyan50,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "كلمة السر",

                          labelStyle: const TextStyle(color: white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: cyan200,
                                width: 2,
                              )),
                          // hintText: "abc@domain.com",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cyan50,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "تأكيد كلمة السر",

                          labelStyle: const TextStyle(color: white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: cyan200,
                                width: 2,
                              )),
                          // hintText: "abc@domain.com",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cyan50,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      const SizedBox(
                        height: 25,
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
                            text: "تسجيل الدخول",
                            color: cyan500),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'لا تملك حساباً؟',
                            style: TextStyle(
                              color: cyan100,
                              shadows: [
                                Shadow(
                                    color: Colors.black54,
                                    blurRadius: 8,
                                    offset: Offset(1, 1))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          TextButton(
                              style: const ButtonStyle(
                                  elevation: WidgetStatePropertyAll(0)),
                              onPressed: () {},
                              child: const Text(
                                'اطلب التسجيل الآن!',
                                style: TextStyle(color: white, shadows: [
                                  Shadow(
                                      color: Colors.black54,
                                      blurRadius: 8,
                                      offset: Offset(1, 1))
                                ]),
                              ))
                        ],
                      ),
                      // const SizedBox(
                      //   height: 25,
                      // )
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
