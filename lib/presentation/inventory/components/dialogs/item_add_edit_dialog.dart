import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_states.dart';

Widget itemAddEditDialog(BuildContext context, {Item? item}) {
  final bool isEditMode = item != null;

  TextEditingController itemnamecontroller =
      TextEditingController(text: item?.name ?? '');
  TextEditingController itemunitcontroller =
      TextEditingController(text: item?.unit ?? '');
  TextEditingController itemstandardquantitycontroller =
      TextEditingController(text: '${item?.standardQuantity ?? ''}');
  TextEditingController itemminimumquantitycontroller =
      TextEditingController(text: '${item?.minimumQuantity ?? ''}');
  final TextEditingController catmenuController = TextEditingController();
  final TextEditingController subcatmenuController = TextEditingController();

  return BlocBuilder<InventoryCubit, InventoryState>(
    builder: (context, state) {
      // Get categories and subcategories from cubit
      final cubit = context.read<InventoryCubit>();
      final categories = cubit.categories;
      final subCategories = cubit.subCategories;
      final selectedCategory = cubit.selectedCategory;
      final selectedSubCategory = cubit.selectedSubCategory;

      return Dialog(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: cyan200),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 1.3,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      isEditMode ? 'تعديل مادة' : 'إضافة مادة جديدة',
                      style: const TextStyle(
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
                    // Item name field
                    defaultTextField(
                      itemnamecontroller,
                      context,
                      'اسم المادة',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    // Unit field
                    defaultTextField(
                      itemunitcontroller,
                      context,
                      'الوحدة',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    // Standard quantity field
                    defaultTextField(
                      itemstandardquantitycontroller,
                      context,
                      'الكمية القياسية',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    // Minimum quantity field
                    defaultTextField(
                      itemminimumquantitycontroller,
                      context,
                      'الحد الأدنى',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    // Action buttons
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
                            text: isEditMode ? 'تحديث' : 'إضافة',
                            function: () {
                              // Call the real add/edit API
                              if (isEditMode) {
                                context
                                    .read<InventoryCubit>()
                                    .updateItem(item.id!, {
                                  'name': itemnamecontroller.text,
                                  'unit': itemunitcontroller.text,
                                  'standard_quantity': int.tryParse(
                                          itemstandardquantitycontroller
                                              .text) ??
                                      0,
                                  'minimum_quantity': int.tryParse(
                                          itemminimumquantitycontroller.text) ??
                                      0,
                                });
                              } else {
                                // Get the current subcategory ID from the cubit
                                final cubit = context.read<InventoryCubit>();
                                if (cubit.selectedSubCategory != null) {
                                  context
                                      .read<InventoryCubit>()
                                      .addItem(cubit.selectedSubCategory!.id!, {
                                    'name': itemnamecontroller.text,
                                    'unit': itemunitcontroller.text,
                                    'standard_quantity': int.tryParse(
                                            itemstandardquantitycontroller
                                                .text) ??
                                        0,
                                    'minimum_quantity': int.tryParse(
                                            itemminimumquantitycontroller
                                                .text) ??
                                        0,
                                  });
                                }
                              }

                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(isEditMode
                                      ? 'تم تحديث المادة'
                                      : 'تم إضافة المادة'),
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
      ));
    },
  );
}

