import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/components/default_button.dart';
import 'package:lambda_dent_dash/constant/components/default_textfield.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';

class EditProfileDialog extends StatelessWidget {
  EditProfileDialog({
    super.key,
  });
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
                        phonenumbercontroller, context, 'رقم الهاتف'),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(addresscontroller, context, 'العنوان'),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
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
