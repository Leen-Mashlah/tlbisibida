import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';

import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/inventory/components/item_edit_quantity_card.dart';

Dialog addQuantityForItem(BuildContext context) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: cyan200),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 2.1,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'تعديل كمية',
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
                      height: 10,
                    ),
                    itemEditQuantityCard(
                      context,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                        text: 'تم',
                        function: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
          ])),
    ),
  );
}
