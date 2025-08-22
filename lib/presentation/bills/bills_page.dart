import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/components/float_button.dart';
import 'package:lambda_dent_dash/presentation/bills/components/bills_table.dart';
import 'package:lambda_dent_dash/presentation/bills/components/add_bill_dialog.dart';
import 'package:lambda_dent_dash/presentation/bills/Cubits/bills_cubit.dart';
import 'package:lambda_dent_dash/presentation/bills/Cubits/bills_state.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';

class BillsPage extends StatelessWidget {
  BillsPage({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillsCubit, BillsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final billsCubit = context.read<BillsCubit>();
        final clientsCubit = context.read<ClientsCubit>();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: defaultTextField(_controller, context, 'بحث',
                            postfixicon: const Icon(Icons.search_rounded)),
                      ),
                      const SizedBox(width: 30),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: DropdownButton(
                          icon: const Icon(Icons.sort),
                          hint: const Text("الترتيب حسب  "),
                          items: const [
                            DropdownMenuItem(
                                value: 'name', child: Text('اسم الزبون')),
                            DropdownMenuItem(
                                value: 'billId', child: Text('رقم الفاتورة')),
                            DropdownMenuItem(
                                value: 'date', child: Text('التاريخ')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (state is BillsLoading && (billsCubit.billsList == null))
                    const Center(child: CircularProgressIndicator())
                  else if (state is BillsError &&
                      (billsCubit.billsList == null))
                    const Center(child: Text('حدث خطأ أثناء تحميل الفواتير'))
                  else
                    const BillsTable(),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            // child: FloatingActionButton(
            //   onPressed: () {
            //         showDialog(
            //             context: context, builder: (context) => AddBillDialog());
            //   },
            //   child: Icon(
            //     color: cyan400,
            //     size: 25.0,
            //   ),
            //   backgroundColor: cyan200,
            // ),
            child: floatButton(
              icon: Icons.add,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        AddBillDialog(clientsCubit: clientsCubit));
              },
            ),
          ),
        );
      },
    );
  }
}
