import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/components/default_button.dart';
import 'package:lambda_dent_dash/constant/components/default_textfield.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/view/clients/components/tables/payment_log_table.dart';

Dialog paymentLogDialog(BuildContext context) {
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController itemunitcontroller = TextEditingController();

  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: cyan200),
              borderRadius: BorderRadius.circular(20)),
          width: 1200, // MediaQuery.of(context).size.width / 4,
          height: 600, //MediaQuery.of(context).size.height / 1.3,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: cyan200, width: .5),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 6),
                              color: Colors.grey,
                              blurRadius: 12)
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(30),
                      height: 500,
                      width: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'إضافة دفعة',
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
                              height: 70,
                            ),
                            defaultTextField(
                              itemnamecontroller,
                              context,
                              'القيمة المضافة',
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            defaultTextField(
                                itemunitcontroller, context, 'تأكيد القيمة'),
                            const SizedBox(
                              height: 70,
                            ),
                            defaultButton(
                                text: 'إضافة',
                                function: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                            width: 900,
                            height: 500,
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                Text(
                                  'سجل الدفعات',
                                  style: TextStyle(
                                      color: cyan400,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                PaymentLogTable(),
                              ],
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
    ),
  );
}
