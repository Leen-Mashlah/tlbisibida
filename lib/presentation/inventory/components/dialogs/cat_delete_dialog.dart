import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_cats.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';

Dialog catDeleteConfirmationDialog(BuildContext context, Category category) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: cyan200),
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.orange,
            ),
            Text(
              'تأكيد الحذف',
              style: TextStyle(
                color: redmain,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: .5,
              width: 100,
              color: cyan200,
              margin: const EdgeInsets.symmetric(vertical: 5),
            ),
            Text(
              'هل أنت متأكد من حذف "${category.name ?? 'Unknown'}"؟',
              style: TextStyle(
                color: cyan600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'سيتم حذف جميع الفئات الفرعية والعناصر المرتبطة بهذه الفئة',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: redButton(
                      text: 'تأكيد الحذف',
                      function: () {
                        // Call the real delete API
                        context
                            .read<InventoryCubit>()
                            .deleteCategory(category.id!);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم حذف "${category.name}"'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
