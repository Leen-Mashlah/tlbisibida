import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';

Dialog itemDeleteConfirmationDialog(BuildContext context, Item item) {
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
                          'حذف مادة',
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
                        Text(
                          'هل أنت متأكد من حذف "${item.name ?? 'Unknown'}"؟',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    foregroundColor: Colors.grey[700],
                                  ),
                                  child: const Text('إلغاء'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: redButton(
                                  text: 'تأكيد الحذف',
                                  function: () {
                                    // Call the real delete API
                                    context
                                        .read<InventoryCubit>()
                                        .deleteItem(item.id!);
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('تم حذف "${item.name}"'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ])))));
}
