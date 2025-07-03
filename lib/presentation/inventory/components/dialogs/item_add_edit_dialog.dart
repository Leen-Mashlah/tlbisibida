import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Dialog itemAddEditDialog(BuildContext context) {
  TextEditingController itemnamecontroller =
      TextEditingController(text: 'سماكة 10');
  TextEditingController itemunitcontroller =
      TextEditingController(text: 'بلوكة');
  TextEditingController itemstandardquantitycontroller =
      TextEditingController(text: '50');
  TextEditingController itemminimumquantitycontroller =
      TextEditingController(text: '10');
  final TextEditingController catmenuController = TextEditingController();
  final TextEditingController subcatmenuController = TextEditingController();

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
                    const Text(
                      'تعديل مادة',
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
                    DropdownMenu<String>(
                        //initialSelection: menuItems.first,
                        width: MediaQuery.of(context).size.width / 4 - 16,
                        controller: catmenuController,
                        hintText: "اختر الصنف",
                        initialSelection: 'صنف1',
                        requestFocusOnTap: true,
                        enableFilter: true,
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: cyan200, width: 1.0),
                              borderRadius: standardBorderRadius),
                        ),
                        menuStyle: const MenuStyle(
                            backgroundColor: WidgetStatePropertyAll(cyan100)),
                        label: const Text('الصنف الرئيسي'),
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(
                              value: 'صنف1', label: 'بلوكات زيركون'),
                          DropdownMenuEntry(
                              value: 'صنف2', label: 'بلوكات اكريل مؤقت'),
                          DropdownMenuEntry(value: 'صنف3', label: 'بودرة خزف'),
                          DropdownMenuEntry(value: 'صنف4', label: 'شمع'),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownMenu<String>(
                        //initialSelection: menuItems.first,
                        //width: MediaQuery.of(context).size.width - 16.0,
                        width: MediaQuery.of(context).size.width / 4 - 16,
                        controller: subcatmenuController,
                        hintText: "اختر الصنف",
                        initialSelection: 'صنف1',
                        requestFocusOnTap: true,
                        enableFilter: true,
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: cyan200, width: 1.0),
                              borderRadius: standardBorderRadius),
                        ),
                        menuStyle: const MenuStyle(
                            backgroundColor: WidgetStatePropertyAll(cyan100)),
                        label: const Text('الصنف الفرعي'),
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: 'صنف1', label: 'صيني'),
                          DropdownMenuEntry(value: 'صنف2', label: 'ألماني'),
                          DropdownMenuEntry(value: 'صنف3', label: 'ملتي لاير'),
                          DropdownMenuEntry(
                              value: 'صنف4', label: 'عالي شفوفية'),
                          DropdownMenuEntry(value: 'صنف5', label: 'كتيم'),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                      itemnamecontroller,
                      context,
                      'اسم المادة',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(itemunitcontroller, context, 'الواحدة'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(itemstandardquantitycontroller, context,
                        'الكمية القياسية'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(itemminimumquantitycontroller, context,
                        'الحد الأدنى للكمية'),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                        text: 'تعديل',
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
