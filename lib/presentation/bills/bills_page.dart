import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/components/float_button.dart';
import 'package:lambda_dent_dash/presentation/bills/components/bills_table.dart';
import 'package:lambda_dent_dash/presentation/bills/components/add_bill_dialog.dart';
import 'package:lambda_dent_dash/presentation/bills/Cubits/bills_cubit.dart';
import 'package:lambda_dent_dash/presentation/bills/Cubits/bills_state.dart';

class BillsPage extends StatelessWidget {
  BillsPage({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        //TODO
      },
      builder: (context, state) {
        BillsCubit billsCubit = context.read<BillsCubit>();
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        DropdownMenuItem(
                            value: 'name', child: Text('اسم الزبون')),
                        DropdownMenuItem(
                            value: 'billId', child: Text('رقم الفاتورة')),
                        DropdownMenuItem(value: 'date', child: Text('التاريخ')),
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
                      context: context, builder: (context) => AddBillDialog());
                },
              ),
            ),
          ],
        ),
      ));
      },
    );
  }
}
