import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';

Widget itemEditQuantityCard(BuildContext context, Item item) {
  TextEditingController addedQuantityController = TextEditingController();
  TextEditingController removedQuantityController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: Card(
        child: Container(
          height: 250,
          width: 300,
          decoration: BoxDecoration(
            color: cyan50op,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cyan500, width: .4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'إضافة كمية',
                  style: TextStyle(
                    color: cyan600,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: .5,
                  width: 100,
                  color: cyan200,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.unit ?? 'kg',
                      style: TextStyle(
                          color: cyan500, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      child: defaultTextField(
                        addedQuantityController,
                        context,
                        'الكمية المضافة',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: defaultTextField(
                    reasonController,
                    context,
                    'سبب الإضافة (اختياري)',
                    keyboardType: TextInputType.text,
                  ),
                ),
                defaultButton(
                  text: 'إضافة الكمية',
                  function: () {
                    final quantityText = addedQuantityController.text.trim();
                    if (quantityText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى إدخال الكمية المضافة'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final quantity = int.tryParse(quantityText);
                    if (quantity == null || quantity <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى إدخال قيمة صحيحة للكمية'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Call the real addItemHistory API
                    context.read<InventoryCubit>().addItemHistory(
                      item.id!,
                      {
                        'quantity': quantity,
                        'reason': reasonController.text.trim().isNotEmpty
                            ? reasonController.text.trim()
                            : 'إضافة كمية',
                        'new_value': (item.quantity ?? 0) + quantity,
                        'recent_value': item.quantity ?? 0,
                      },
                    );

                    // Clear fields and show success message
                    addedQuantityController.clear();
                    reasonController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('تم إضافة $quantity ${item.unit ?? 'kg'}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      back: Card(
        child: Container(
          height: 250,
          width: 300,
          decoration: BoxDecoration(
            color: const Color.fromARGB(112, 255, 200, 206),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cyan500, width: .4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'خصم كمية',
                  style: TextStyle(
                    color: redmain,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: .5,
                  width: 100,
                  color: redmain,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: defaultTextField(
                        removedQuantityController,
                        context,
                        'الكمية المحذوفة',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.unit ?? 'kg',
                      style: TextStyle(
                          color: redmain, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: defaultTextField(
                    reasonController,
                    context,
                    'سبب الخصم (اختياري)',
                    keyboardType: TextInputType.text,
                  ),
                ),
                defaultButton(
                  text: 'خصم الكمية',
                  function: () {
                    final quantityText = removedQuantityController.text.trim();
                    if (quantityText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى إدخال الكمية المحذوفة'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final quantity = int.tryParse(quantityText);
                    if (quantity == null || quantity <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى إدخال قيمة صحيحة للكمية'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Check if we have enough quantity to remove
                    if ((item.quantity ?? 0) < quantity) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'الكمية المتوفرة (${item.quantity}) أقل من الكمية المطلوب خصمها ($quantity)'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Call the real addItemHistory API with negative quantity
                    context.read<InventoryCubit>().addItemHistory(
                      item.id!,
                      {
                        'quantity': -quantity,
                        'reason': reasonController.text.trim().isNotEmpty
                            ? reasonController.text.trim()
                            : 'خصم كمية',
                        'new_value': (item.quantity ?? 0) - quantity,
                        'recent_value': item.quantity ?? 0,
                      },
                    );

                    // Clear fields and show success message
                    removedQuantityController.clear();
                    reasonController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم خصم $quantity ${item.unit ?? 'kg'}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
