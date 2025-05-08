import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/add_cat_dialog%20.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/add_subcat_dialog%20.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/cat_delete_dialog.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/edit_cat_dialog.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/edit_subcat_dialog.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/subCat_delete_dialog.dart';

Dialog CatManagementDialog(BuildContext context) {
  final TextEditingController catmenuController = TextEditingController();
  final TextEditingController subcatmenuController = TextEditingController();

  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: cyan200),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 1.3,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return catDeleteConfirmationDialog(
                                            context);
                                      });
                                },
                                icon: Icon(Icons.delete_outline_rounded)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return editCatDialog(context);
                                      });
                                },
                                icon: Icon(Icons.edit_note_rounded)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return addCatDialog(context);
                                      });
                                },
                                icon: Icon(Icons.post_add_rounded)),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        DropdownMenu<String>(
                            //initialSelection: menuItems.first,
                            width: MediaQuery.of(context).size.width / 5 - 16,
                            controller: catmenuController,
                            // leadingIcon:
                            hintText: "اختر الصنف",
                            initialSelection: 'صنف1',
                            requestFocusOnTap: true,
                            enableFilter: true,
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: cyan200, width: 1.0),
                                  borderRadius: standardBorderRadius),
                            ),
                            menuStyle: const MenuStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(cyan100)),
                            label: const Text('الصنف الرئيسي'),
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                  value: 'صنف1', label: 'بلوكات زيركون'),
                              DropdownMenuEntry(
                                  value: 'صنف2', label: 'بلوكات اكريل مؤقت'),
                              DropdownMenuEntry(
                                  value: 'صنف3', label: 'بودرة خزف'),
                              DropdownMenuEntry(value: 'صنف4', label: 'شمع'),
                            ]),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      width: 100,
                      color: cyan300,
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return subcatDeleteConfirmationDialog(
                                            context);
                                      });
                                },
                                icon: Icon(Icons.delete_outline_rounded)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return editSubcatDialog(context);
                                      });
                                },
                                icon: Icon(Icons.edit_note_rounded)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return addSubcatDialog(context);
                                      });
                                },
                                icon: Icon(Icons.post_add_rounded)),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        DropdownMenu<String>(
                            //initialSelection: menuItems.first,
                            //width: MediaQuery.of(context).size.width - 16.0,
                            width: MediaQuery.of(context).size.width / 5 - 16,
                            controller: subcatmenuController,
                            hintText: "اختر الصنف",
                            initialSelection: 'صنف1',
                            requestFocusOnTap: true,
                            enableFilter: true,
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: cyan200, width: 1.0),
                                  borderRadius: standardBorderRadius),
                            ),
                            menuStyle: const MenuStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(cyan100)),
                            label: const Text('الصنف الفرعي'),
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: 'صنف1', label: 'صيني'),
                              DropdownMenuEntry(value: 'صنف2', label: 'ألماني'),
                              DropdownMenuEntry(
                                  value: 'صنف3', label: 'ملتي لاير'),
                              DropdownMenuEntry(
                                  value: 'صنف4', label: 'عالي شفوفية'),
                              DropdownMenuEntry(value: 'صنف5', label: 'كتيم'),
                            ]),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                        text: 'تم',
                        function: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
          ])),
    ),
  );
}
