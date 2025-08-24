import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_cats.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';

Widget addSubcatDialog(BuildContext context) {
  TextEditingController subcategoryNameController = TextEditingController();

  return BlocBuilder<InventoryCubit, dynamic>(
    builder: (context, state) {
      final cubit = context.read<InventoryCubit>();
      final selectedCategory = cubit.selectedCategory;

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
                        'إضافة صنف فرعي',
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

                      // Show selected category info
                      if (selectedCategory != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: cyan50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: cyan200),
                          ),
                          child: Text(
                            'الفئة الرئيسية: ${selectedCategory.name}',
                            style: TextStyle(
                              color: cyan600,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange[200]!),
                          ),
                          child: Text(
                            'يرجى اختيار فئة رئيسية أولاً',
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],

                      const Text('أدخل اسم الفئة الفرعية الجديدة'),
                      SizedBox(
                        width: 250,
                        child: defaultTextField(
                          subcategoryNameController,
                          context,
                          'اسم الفئة الفرعية',
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
                                if (selectedCategory == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('يرجى اختيار فئة رئيسية أولاً'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                final subcategoryName =
                                    subcategoryNameController.text.trim();
                                if (subcategoryName.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('يرجى إدخال اسم الفئة الفرعية'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                // Call the real addSubcategory API
                                cubit.addSubcategory(
                                    selectedCategory.id!, subcategoryName);

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'تم إضافة الفئة الفرعية "$subcategoryName"'),
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
    },
  );
}
