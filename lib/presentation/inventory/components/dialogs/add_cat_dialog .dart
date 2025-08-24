import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';

Dialog addCatDialog(BuildContext context) {
  TextEditingController categoryNameController = TextEditingController();

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
                  const Text(
                    'إضافة صنف رئيسي',
                    style: TextStyle(
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
                  const Text('أدخل اسم الصنف الجديد'),
                  SizedBox(
                    width: 250,
                    child: defaultTextField(
                      categoryNameController,
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
                          text: 'إضافة',
                          function: () {
                            final categoryName =
                                categoryNameController.text.trim();
                            if (categoryName.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('يرجى إدخال اسم الصنف'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // Call the real addCategory API
                            context
                                .read<InventoryCubit>()
                                .addCategory(categoryName);

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('تم إضافة الصنف "$categoryName"'),
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
