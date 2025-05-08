import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/add_quantity_for_item_dialog.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/item_log_dialog.dart';

Row bottomActionPaymentsLogButtons(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return itemLogDialog(context);
                });
          },
          child: Container(
            height: 50,
            decoration: const BoxDecoration(color: cyan50op),
            child: const Icon(Icons.menu, color: cyan400),
          ),
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return addQuantityForItem(context);
              },
            );
          },
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              color: cyan100,
            ),
            child: const Icon(
              Icons.add,
              color: cyan400,
            ),
          ),
        ),
      ),
    ],
  );
}
