import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/components/default_button.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';

Dialog catDeleteConfirmationDialog(BuildContext context) {
  return Dialog(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: redmid),
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width / 4,
              //height: MediaQuery.of(context).size.height / 1.3,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'حذف صنف رئيسي',
                          style: TextStyle(
                              color: redmain,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: .5,
                          width: 100,
                          color: redbackground,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        const Text('هل أنت متأكد من حذف هذا الصنف؟ '),
                        const SizedBox(
                          height: 20,
                        ),
                        redButton(
                            text: 'تأكيد الحذف',
                            function: () {
                              Navigator.of(context).pop();
                            })
                      ])))));
}
