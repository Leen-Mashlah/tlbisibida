import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/components/image_picker.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class EditProfileDialog extends StatefulWidget {
  EditProfileDialog({
    super.key,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  List<Image> images = [];

  TextEditingController profilenamecontroller = TextEditingController();

  TextEditingController phonenumbercontroller = TextEditingController();

  TextEditingController addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'تعديل الملف الشخصي',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: cyan200,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultTextField(
                        profilenamecontroller, context, 'اسم المخبر'),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        phonenumbercontroller, context, 'رقم الهاتف',
                        postfixicon: Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: cyan100,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_circle_rounded,
                                color: cyan400,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(addresscontroller, context, 'العنوان'),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(addresscontroller, context, 'الاختصاص'),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        addresscontroller, context, 'مدير المخبر '),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              imagePicker(images),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                  text: 'تعديل',
                  function: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

void image_picker(Image images) async {
  Image? images = await ImagePickerWeb.getImageAsWidget();
}
