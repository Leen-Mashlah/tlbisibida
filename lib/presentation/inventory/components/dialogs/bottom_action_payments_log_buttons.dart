import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/item_log_dialog.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/item_edit_quantity_card.dart';

Row bottomActionPaymentsLogButtons(BuildContext context, Item item) {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return itemLogDialog(context, item);
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
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: itemEditQuantityCard(context, item),
                  ),
                );
              },
            );
          },
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              color: cyan100,
            ),
            child: Center(
                child: Text(
              '- / +',
              style: TextStyle(color: cyan500, fontSize: 22),
            )),
          ),
        ),
      ),
    ],
  );
}
