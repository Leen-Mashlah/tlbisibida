import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/components/default_textfield.dart';
import 'package:lambda_dent_dash/constant/components/float_button.dart';
import 'package:lambda_dent_dash/view/bills/components/bills_table.dart';
import 'package:lambda_dent_dash/view/bills/components/add_bill_dialog.dart';

class BillsPage extends StatelessWidget {
  BillsPage({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: defaultTextField(_controller, context, 'بحث',
                        postfixicon: const Icon(Icons.search_rounded)),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  DropdownButton(
                    icon: const Icon(Icons.sort),
                    hint: const Text("الترتيب حسب"),
                    items: const [
                      DropdownMenuItem(value: 'BL1', child: Text('اسم الزبون')),
                      DropdownMenuItem(
                          value: 'BL2', child: Text('رقم الفاتورة')),
                      DropdownMenuItem(value: 'BL3', child: Text('التاريخ')),
                    ],
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const BillsTable(),
            ],
          )),
          Positioned(
            bottom: 20,
            right: 20,
            child: floatButton(
              icon: Icons.add,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => const AddBillDialog());
              },
            ),
          ),
        ],
      ),
    ));
  }
}
