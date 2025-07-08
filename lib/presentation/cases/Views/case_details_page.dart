import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/image_gallery.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/comments/case_comments_drawer.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/case_details_table.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/case_process_timeline.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';

class CaseDetails extends StatelessWidget {
  CaseDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CasesCubit, String>(
          listener: (context, state) {
            // TODO: implement listener
            if (state == 'comments_loaded') {
              Scaffold.of(context).openDrawer();
            }
          },
          builder: (context, state) {
            CasesCubit casesCubit = context.read<CasesCubit>();

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 10, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CaseProcessTimeline(
                        currentProcessIndex:
                            casesCubit.medicalCase!.medicalCaseDetails!.status!,
                        onProcessIndexChanged: (value) {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 400,
                            height:
                                (MediaQuery.of(context).size.height / 1.3) - 50,
                            decoration: BoxDecoration(
                                color: cyan300,
                                border: Border.all(color: cyan300, width: .5),
                                borderRadius: BorderRadius.circular(50)),
                            child: const CaseDetailsTable(),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 350,
                            height:
                                (MediaQuery.of(context).size.height / 1.3) - 50,
                            decoration: BoxDecoration(
                                color: cyan200,
                                border: Border.all(color: cyan300, width: .5),
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ImageGallery(images: casesCubit.imgList),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: cyan500, width: .5),
                                borderRadius: BorderRadius.circular(50)),
                            width: 400,
                            height:
                                (MediaQuery.of(context).size.height / 1.3) - 50,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'اسم الطبيب',
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.dentistFirstName} ${casesCubit.medicalCase!.dentistLastName}'),
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.patientFullName}'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'العمر',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(
                                              '${casesCubit.medicalCase!.medicalCaseDetails!.age}'),
                                          const SizedBox(
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

                                      Column(
                                        children: [
                                          const Text(
                                            'الجنس',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(
                                              '${casesCubit.medicalCase!.patientGender}'),
                                          const SizedBox(
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.medicalCaseDetails!.shade}'),
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.medicalCaseDetails!.createdAt}'),
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.medicalCaseDetails!.expectedDeliveryDate}'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'حالة إعادة',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(casesCubit.medicalCase!
                                                  .medicalCaseDetails!.repeat!
                                              ? 'نعم'
                                              : 'لا'),
                                          const SizedBox(
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
                                      Column(
                                        children: [
                                          const Text(
                                            'تحتاج إلى تجربة',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(casesCubit.medicalCase!
                                                  .medicalCaseDetails!.repeat!
                                              ? 'نعم'
                                              : 'لا'),
                                          const SizedBox(
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: cyan300, width: .3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 250,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          '${casesCubit.medicalCase!.medicalCaseDetails!.notes}'),
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
                    ],
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).size.height / 5,
                    right: 0,
                    child: Builder(
                      builder: (context) => RotatedBox(
                        quarterTurns: 3,
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(100),
                                              bottom: Radius.circular(5)))),
                                  elevation: WidgetStatePropertyAll(0),
                                  shadowColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                  backgroundColor:
                                      WidgetStatePropertyAll(cyan300)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.height / 6,
                                  ),
                                  const Text(
                                    'التعليقات',
                                    style: TextStyle(color: white),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.height / 6,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                casesCubit.getcomment(casesCubit
                                    .medicalCase!.medicalCaseDetails!.id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            );
          },
        ),
        drawer: caseComments(context));
  }
}
