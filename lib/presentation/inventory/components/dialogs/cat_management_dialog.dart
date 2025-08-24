import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_cats.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_subcats.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/add_cat_dialog%20.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/add_subcat_dialog%20.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/cat_delete_dialog.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/edit_cat_dialog.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/edit_subcat_dialog.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/subCat_delete_dialog.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_states.dart';

Widget CatManagementDialog(BuildContext context) {
  final TextEditingController catmenuController = TextEditingController();
  final TextEditingController subcatmenuController = TextEditingController();

  return BlocBuilder<InventoryCubit, InventoryState>(
    builder: (context, state) {
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
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 2,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'إدارة الأصناف',
                      style: TextStyle(
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
                    Row(
                      children: [
                        DropdownMenu<Category>(
                          width: MediaQuery.of(context).size.width / 5 - 16,
                          controller: catmenuController,
                          hintText: "اختر الصنف",
                          requestFocusOnTap: true,
                          enableFilter: true,
                          inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: cyan200, width: 1.0),
                                borderRadius: standardBorderRadius),
                          ),
                          menuStyle: const MenuStyle(
                              backgroundColor: WidgetStatePropertyAll(cyan100)),
                          label: const Text('الصنف الرئيسي'),
                          dropdownMenuEntries: categories.map((category) {
                            return DropdownMenuEntry<Category>(
                              value: category,
                              label: category.name ?? 'Unknown',
                            );
                          }).toList(),
                          onSelected: (Category? category) {
                            if (category != null) {
                              cubit.selectCategory(category);
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return addCatDialog(context);
                                      });
                                },
                                icon: Icon(
                                  Icons.post_add_rounded,
                                  color: cyan600,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (selectedCategory != null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return editCatDialog(
                                              context, selectedCategory!);
                                        });
                                  }
                                },
                                icon: Icon(
                                  Icons.edit_note_rounded,
                                  color: cyan300,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (selectedCategory != null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return catDeleteConfirmationDialog(
                                              context, selectedCategory!);
                                        });
                                  }
                                },
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: redmain,
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        DropdownMenu<SubCategoryRepository>(
                          width: MediaQuery.of(context).size.width / 5 - 16,
                          controller: subcatmenuController,
                          hintText: "اختر الصنف الفرعي",
                          requestFocusOnTap: true,
                          enableFilter: true,
                          inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: cyan200, width: 1.0),
                                borderRadius: standardBorderRadius),
                          ),
                          menuStyle: const MenuStyle(
                              backgroundColor: WidgetStatePropertyAll(cyan100)),
                          label: const Text('الصنف الفرعي'),
                          dropdownMenuEntries: subCategories.map((subCategory) {
                            return DropdownMenuEntry<SubCategoryRepository>(
                              value: subCategory,
                              label: subCategory.name ?? 'Unknown',
                            );
                          }).toList(),
                          onSelected: (SubCategoryRepository? subCategory) {
                            if (subCategory != null) {
                              cubit.selectSubCategory(subCategory);
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return addSubcatDialog(context);
                                      });
                                },
                                icon: Icon(
                                  Icons.post_add_rounded,
                                  color: cyan600,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (selectedSubCategory != null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return editSubcatDialog(
                                              context, selectedSubCategory!);
                                        });
                                  }
                                },
                                icon: Icon(
                                  Icons.edit_note_rounded,
                                  color: cyan300,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (selectedSubCategory != null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return subcatDeleteConfirmationDialog(
                                              context, selectedSubCategory!);
                                        });
                                  }
                                },
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: redmain,
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Show current selection info
                    if (selectedCategory != null || selectedSubCategory != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cyan50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: cyan200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (selectedCategory != null)
                              Text(
                                'الفئة المحددة: ${selectedCategory.name}',
                                style: TextStyle(
                                  color: cyan600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (selectedSubCategory != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                'الفئة الفرعية المحددة: ${selectedSubCategory.name}',
                                style: TextStyle(
                                  color: cyan500,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
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
