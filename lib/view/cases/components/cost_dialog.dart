import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart'; // Assuming this contains your cyan300 and white colors

class CostDialog extends StatefulWidget {
  const CostDialog({super.key}); // No need to pass index to the dialog itself

  @override
  State<CostDialog> createState() => _CostDialogState();
}

class _CostDialogState extends State<CostDialog> {
  final TextEditingController _costController = TextEditingController();

  @override
  void dispose() {
    _costController
        .dispose(); // Dispose of the controller when the state is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: cyan200),
                borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 2.6,
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'أدخل تكلفة الحالة',
                        style: TextStyle(
                            color: cyan400,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: .5,
                        width: 100,
                        color: cyan200,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 250,
                        child: defaultTextField(_costController, context, '',
                            keyboardType: TextInputType.number),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      defaultButton(
                          text: 'إرسال',
                          function: () {
                            Navigator.of(context).pop(_costController.text);
                          })
                    ],
                  ),
                ),
              ),
            ])),
      ),
    );

    // return AlertDialog(
    //   title: const Text("أدخل تكلفة الحالة"),
    //   content: defaultTextField(
    //     _costController,
    //     context,
    //     '',
    //     keyboardType: TextInputType.number,
    //   ),
    //   actions: <Widget>[
    //     defaultButton(
    //       text: "إلغاء الأمر",
    //       function: () {
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //     defaultButton(
    //         function: () {
    //           // Return the entered cost when submit is pressed
    //           Navigator.of(context).pop(_costController.text);
    //         },
    //         text: 'إرسال'),
    //   ],
    // );
  }
}
