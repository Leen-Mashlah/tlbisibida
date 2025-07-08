// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class BillPreviewDialog extends StatelessWidget {
  const BillPreviewDialog({
    super.key,
  });

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
                'مسودة الفاتورة',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 600,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        listItemBuilder(context, index),
                    itemCount: 20,
                    separatorBuilder: (BuildContext context, int index) =>
                        Container()),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: cyan200,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      child: Text(
                        '3.000.000',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'المجموع',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  defaultButton(
                      text: 'إرسال',
                      function: () {
                        //TODO Send Bill
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  redButton(
                      text: 'إلغاء',
                      function: () {
                        Navigator.pop(context);
                      }),
                ],
              )
            ]),
      ),
    ));
  }
}

listItemBuilder(context, index) {
  return InkWell(
    onTap: () {
      //Get.toNamed('/orderdetails', arguments: {'id': index});
    },
    child: Container(
      decoration: BoxDecoration(border: Border.all(width: .5, color: cyan200)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              //controller.billsListModel!.data[index].case_id.toString(),
              '001',
              style: TextStyle(fontSize: 18, color: cyan600),
              overflow: TextOverflow.ellipsis,
            ),
            Column(
              children: [
                const Text('Patient Name:' +
                    ' ' +
                    //controller.billsListModel!.data[index].patient_name
                    'Rokaia'),
                Text('Date:' +
                    ' ' +
                    //controller.billsListModel!.data[index].created_at
                    '09/12/2024'.toString().substring(0, 10)),
              ],
            ),
            const Text('Bill: ' +
                //controller.billsListModel!.data[index].total_price.toString()
                '3,000,000'),
            //style: TextStyle(fontSize: 22, color: cyan400),
          ],
        ),
      ),
    ),
  );
}
