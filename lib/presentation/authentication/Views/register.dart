// ignore_for_file: prefer_const_constructors

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/register_2.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_state.dart';

class RegisterPage extends StatelessWidget {
  // AdminLoginController adminAuth=Get.put(AdminLoginController());
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

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistered) {
            // handle registration success
          } else if (state is AuthError) {
            // handle error
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
                                child: TextField(
                                  controller: _labNameController,
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
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _managerNameController,
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
                              ),
                            ],
                          ),
                          TextField(
                            controller: _emailController,
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
                          TextField(
                            controller: _passwordController,
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
                            controller: _passwordConfirmController,
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
                          TextField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              labelText: "رقم الهاتف",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: DropdownSearch<String>(
                                  decoratorProps: DropDownDecoratorProps(
                                      baseStyle: TextStyle(color: Colors.white),
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
                                child: TextField(
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                    labelText: "العنوان",
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
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
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
                              // locator<NavigationService>()
                              //     .navigateTo(register2PageRoute);
                              // Navigate preserving the same AuthCubit instance
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: cubit,
                                    child: Register2Page(),
                                  ),
                                  settings: const RouteSettings(
                                      name: register2PageDisplayName),
                                ),
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
                                        side: const BorderSide(color: cyan500),
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            child: const CustomText(
                                text: "متابعة ", color: cyan500),
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
