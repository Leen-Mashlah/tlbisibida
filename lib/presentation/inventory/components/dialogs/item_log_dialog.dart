import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/item_log_table.dart';

Dialog itemLogDialog(BuildContext context, Item item) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'سجل المادة: ${item.name ?? 'Unknown'}',
            style: const TextStyle(
                color: cyan400, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 1.3,
              child: const CustomScrollView(slivers: [
                SliverFillRemaining(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                      child: ItemLogTable()),
                ),
              ])),
        ],
      ),
    ),
  );
}
