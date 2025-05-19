import 'package:flutter/material.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class AuthenticationPage extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthenticationPage({super.key});

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
            child: const Card(
              color: Color.fromARGB(159, 48, 195, 178),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image(
                        image: AssetImage(
                      "assets/logo_v2.png",
                    )),
                  ),
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(fontSize: 18, color: cyan500),
                  ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
