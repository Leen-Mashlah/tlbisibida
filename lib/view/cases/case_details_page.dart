import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/components/float_button.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/view/bills/components/add_bill_dialog.dart';
import 'package:lambda_dent_dash/view/cases/components/case_details_table.dart';

class CaseDetails extends StatelessWidget {
  const CaseDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: 400,
                  height: 600,
                  decoration: BoxDecoration(
                      color: cyan300,
                      border: Border.all(color: cyan300, width: .5),
                      borderRadius: BorderRadius.circular(50)),
                  child: const CaseDetailsTable(),
                ),
                Container(
                  width: 400,
                  height: 600,
                  decoration: BoxDecoration(
                      color: cyan300,
                      border: Border.all(color: cyan300, width: .5),
                      borderRadius: BorderRadius.circular(50)),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: cyan500, width: .5),
                      borderRadius: BorderRadius.circular(50)),
                  width: 400,
                  height: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'اسم الزبون',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        const Text('تحسين التحسيني'),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'اسم المريض',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        const Text('تحسين التحسيني'),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'العمر',
                                  style:
                                      TextStyle(color: cyan600, fontSize: 16),
                                ),
                                Text('11'),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Container(
                              height: 25,
                              width: .5,
                              color: cyan400,
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            const Column(
                              children: [
                                Text(
                                  'الجنس',
                                  style:
                                      TextStyle(color: cyan600, fontSize: 16),
                                ),
                                Text('أنثى'),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'اللون',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        const Text('B2'),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'تاريخ إنشاء الطلب',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        const Text('6/10/2024'),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'تاريخ التسليم',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        const Text('20/10/2024'),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  ' حالة إعادة',
                                  style:
                                      TextStyle(color: cyan600, fontSize: 16),
                                ),
                                Text('لا'),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Container(
                              height: 25,
                              width: .5,
                              color: cyan400,
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            const Column(
                              children: [
                                Text(
                                  'تحتاج إلى تجربة',
                                  style:
                                      TextStyle(color: cyan600, fontSize: 16),
                                ),
                                Text('نعم'),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'الملاحظات',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: cyan300, width: .3),
                              borderRadius: BorderRadius.circular(20)),
                          width: 250,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'تىتى لااتنا الااالا انم قيقي صغقه يقخميغف غفبفغي غفبغفبف فغبغفبف غفبفب فبفغب هعلالا 44 ممغع برفالؤ غبفبفب عغنلا '),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          height: .3,
                          color: cyan300,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'التعليقات',
                          style: TextStyle(color: cyan600, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: cyan300, width: .3),
                              borderRadius: BorderRadius.circular(20)),
                          width: 250,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'تىتى لااتنا الااالا انم قيقي صغقه يقخميغف غفبفغي غفبغفبف فغبغفبف غفبفب فبفغب هعلالا 44 ممغع برفالؤ غبفبفب عغنلا '),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: floatButton(
            icon: Icons.add,
            onTap: () {
              showDialog(
                  context: context, builder: (context) => const AddBillDialog());
            },
          ),
        ),
      ],
    ));
  }
}
