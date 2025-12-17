// ignore_for_file: prefer_const_constructors

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/animated_snack_bar.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

import '../Cubits/auth_state.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _managerNameController = TextEditingController();
  final TextEditingController _labNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
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
  String selectedProvince = 'دمشق';
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterCooking) {
            locator<NavigationService>().navigateTo(register2PageRoute);
          } else if (state is AuthError) {
            showSnackBar(context,
                message: 'فشلت عملية التسجيل - تأكد من المدخلات ثم حاول مجدداً',
                type: AnimatedSnackBarType.error);
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
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
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
                              'إنشاء حساب',
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
                            Row(
                              children: [
                                Expanded(
                                  child: defaultTextField(
                                    _labNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال اسم المخبر';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                    context,
                                    "اسم المخبر",
                                    labelStyle: const TextStyle(color: white),
                                    activeColor: cyan200,
                                    inactiveColor: cyan50,
                                    // focusedBorderRadius:
                                    //     BorderRadius.circular(30),
                                    // enabledBorderRadius:
                                    //     BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: defaultTextField(
                                    _managerNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال اسم المدير';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                    context,
                                    "اسم المدير",
                                    labelStyle: const TextStyle(color: white),
                                    activeColor: cyan200,
                                    inactiveColor: cyan50,
                                    // focusedBorderRadius:
                                    //     BorderRadius.circular(30),
                                    // enabledBorderRadius:
                                    //     BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                            defaultTextField(
                              _emailController,
                              context,
                              "البريد الالكتروني",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال البريد الإلكتروني';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'الرجاء إدخال بريد إلكتروني صالح';
                                }
                                return null;
                              },
                              labelStyle: const TextStyle(color: white),
                              activeColor: cyan200,
                              inactiveColor: cyan50,
                              // focusedBorderRadius: BorderRadius.circular(30),
                              // enabledBorderRadius: BorderRadius.circular(20),
                            ),
                            defaultTextField(
                              _passwordController,
                              context,
                              "كلمة السر",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال كلمة المرور';
                                }
                                if (value.length < 8) {
                                  return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                                }
                                return null;
                              },
                              obscureText: !cubit.showPassword,
                              postfixicon: IconButton(
                                icon: Icon(
                                  !cubit.showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: cyan50,
                                ),
                                onPressed: () =>
                                    cubit.togglePasswordVisibility(),
                              ),
                              labelStyle: const TextStyle(color: white),
                              activeColor: cyan200,
                              inactiveColor: cyan50,
                              // focusedBorderRadius: BorderRadius.circular(30),
                              // enabledBorderRadius: BorderRadius.circular(20),
                            ),
                            defaultTextField(
                              _passwordConfirmController,
                              context,
                              "تأكيد كلمة السر",
                              obscureText: !cubit.showPassword,
                              postfixicon: IconButton(
                                icon: Icon(
                                  cubit.showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: cyan50,
                                ),
                                onPressed: () =>
                                    cubit.togglePasswordVisibility(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال كلمة المرور';
                                }
                                if (value.length < 8) {
                                  return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                                }
                                if (value != _passwordController.text) {
                                  return 'كلمتا المرور غير متطابقتين';
                                }
                                return null;
                              },
                              labelStyle: const TextStyle(color: white),
                              activeColor: cyan200,
                              inactiveColor: cyan50,
                              // focusedBorderRadius: BorderRadius.circular(30),
                              // enabledBorderRadius: BorderRadius.circular(20),
                            ),
                            defaultTextField(
                              _phoneNumberController,
                              context,
                              "رقم الهاتف",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الهاتف';
                                }
                                if (!RegExp(r'^09\d{8}$').hasMatch(value)) {
                                  return 'الرجاء إدخال رقم هاتف صحيح (09XXXXXXXX)';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              labelStyle: const TextStyle(color: white),
                              activeColor: cyan200,
                              inactiveColor: cyan50,
                              focusedBorderRadius: BorderRadius.circular(30),
                              enabledBorderRadius: BorderRadius.circular(20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: DropdownSearch<String>(
                                    decoratorProps: DropDownDecoratorProps(
                                        baseStyle:
                                            TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                            // labelText: 'المحافظة',
                                            // labelStyle:
                                            //     TextStyle(color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: cyan50,
                                                width: .5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            isCollapsed: true,
                                            // label: Text('المحافظة'),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ))),
                                    mode: Mode.form,
                                    selectedItem: selectedProvince,
                                    onChanged: (value) {
                                      selectedProvince = value.toString();
                                    },
                                    items: (f, cs) => provincesList,
                                    suffixProps: DropdownSuffixProps(
                                      clearButtonProps:
                                          ClearButtonProps(isVisible: false),
                                    ),
                                    dropdownBuilder: (context, selectedItem) {
                                      if (selectedItem == null) {
                                        return SizedBox.shrink();
                                      }
                                      return ListTile(
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
                                        title: Text(selectedItem,
                                            style: TextStyle(color: white)),
                                      );
                                    },
                                    popupProps: PopupProps.menu(
                                      disableFilter: true,
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                      itemBuilder:
                                          (ctx, item, isDisabled, isSelected) {
                                        return ListTile(
                                          selected: isSelected,
                                          title: Text(
                                            item,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //
                                Expanded(
                                  flex: 4,
                                  child: defaultTextField(
                                    _addressController,
                                    context,
                                    "العنوان",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال العنوان';
                                      }
                                      return null;
                                    },
                                    labelStyle: const TextStyle(color: white),
                                    activeColor: cyan200,
                                    inactiveColor: cyan50,
                                    focusedBorderRadius:
                                        BorderRadius.circular(30),
                                    enabledBorderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final valid =
                                    _formKey.currentState?.validate() ?? false;
                                if (!valid) {
                                  showSnackBar(context,
                                      message:
                                          'الرجاء تصحيح الأخطاء في النموذج.',
                                      type: AnimatedSnackBarType.error);
                                  return;
                                }
                                cubit.cookregistryfisrt(
                                  guard: 'lab_manager',
                                  fullName: _managerNameController.text,
                                  labName: _labNameController.text,
                                  email: _emailController.text,
                                  address: _addressController.text,
                                  password: _passwordController.text,
                                  passwordConfirmation:
                                      _passwordConfirmController.text,
                                  labPhone: [
                                    _phoneNumberController.text,
                                    _phoneNumberController.text
                                  ],
                                  province: selectedProvince,
                                );
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
                                  text: "متابعة إنشاء حساب", color: cyan500),
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
        },
      ),
    );
  }
}
