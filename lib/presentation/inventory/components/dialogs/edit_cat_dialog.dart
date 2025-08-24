import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_cats.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';

Dialog editCatDialog(BuildContext context, Category category) {
  TextEditingController catnamecontroller =
      TextEditingController(text: category.name ?? '');

  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: cyan200),
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 2.3,
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'تعديل صنف رئيسي: ${category.name ?? 'Unknown'}',
                    style: const TextStyle(
                      color: cyan400,
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
                  const SizedBox(height: 10),
                  const Text('أدخل الاسم الجديد'),
                  SizedBox(
                    width: 250,
                    child: defaultTextField(
                      catnamecontroller,
                      context,
                      'اسم الصنف',
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.grey[700],
                          ),
                          child: const Text('إلغاء'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: defaultButton(
                          text: 'تحديث',
                          function: () {
                            // Call the real update API
                            context.read<InventoryCubit>().updateCategory(
                                  category.id!,
                                  catnamecontroller.text,
                                );
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم تحديث الصنف'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
