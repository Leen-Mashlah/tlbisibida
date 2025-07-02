// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/teeth_pattern.png',
                ),

                // fit: BoxFit.,
                repeat: ImageRepeat.repeat),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(149, 229, 243, 241),
                  cyan50,
                  cyan100,
                  cyan100,
                  // cyan200,
                  // cyan200,
                  cyan100,
                  cyan100,
                  cyan50,
                ])),
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    width: 600,
                    height: 120,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(127, 143, 229, 220),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: cyan500, width: .5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'أهلا بكم في تطبيق',
                            style: TextStyle(color: cyan600),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'TUSK',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            'يمكنكم تسجيل الدخول كـَ',
                            style: TextStyle(color: cyan600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, authenticationPageRoute);
                      // context.push(loginRoute);
                    },
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 230,
                          width: 230,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: cyan600, width: .5)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  size: 100,
                                  color: cyan300,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  color: cyan500,
                                  height: .5,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'مدير المخبر',
                                  style: TextStyle(
                                      color: cyan600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, authenticationPageRoute);
                      // context.push(loginRoute);
                    },
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 230,
                          width: 230,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: cyan600, width: .5)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  // TuskIcons.dentist,
                                  Icons.person_outline_rounded,

                                  size: 100,
                                  color: cyan400,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  color: cyan500,
                                  height: .5,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'مدير المخزن',
                                  style: TextStyle(
                                      color: cyan600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, authenticationPageRoute);
                      // context.push(loginRoute);
                    },
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          width: 230,
                          height: 230,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: cyan600, width: .5)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  // TuskIcons.secretary,
                                  Icons.person_outline_rounded,

                                  size: 100,
                                  color: cyan500,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  color: cyan500,
                                  height: .5,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'مدير الشؤون المالية',
                                  style: TextStyle(
                                      color: cyan600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
