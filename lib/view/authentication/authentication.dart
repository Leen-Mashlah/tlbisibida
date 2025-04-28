import 'package:flutter/material.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class AuthenticationPage extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset("assets/icons/logo.png"),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Welcome back to the admin panel.",
                    color: Colors.grey[300],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      const CustomText(
                        text: "Remeber Me",
                      ),
                    ],
                  ),
                  const CustomText(text: "Forgot password?", color: cyan400)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                // onTap: adminAuth.isLoading.value
                //     ? null
                //     : ()async {
                //         adminAuth.admin_login(email.text, password.text);
                //          Get.offNamed("Employees");

                //       },
                child: Container(
                  decoration: BoxDecoration(
                      color: cyan400, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child:
                      //  adminAuth.isLoading.value
                      //     ? CircularProgressIndicator(
                      //         valueColor:
                      //             AlwaysStoppedAnimation<Color>(Colors.white))
                      //     :
                      const CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                  text: const TextSpan(children: [
                TextSpan(text: "Do not have admin credentials? "),
                TextSpan(
                    text: "Request Credentials! ",
                    style: TextStyle(color: cyan400))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
