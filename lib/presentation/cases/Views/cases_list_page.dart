// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/float_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class CasesListPage extends StatelessWidget {
  const CasesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CasesCubit, String>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          CasesCubit casesCubit = context.read<CasesCubit>();
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75.0),
                child: Center(
                  child: state == 'case_list_loaded'
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width / 1.3,
                          // height: MediaQuery.of(context).size.height / 1.4,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _column(
                                    'accepted',
                                    casesCubit,
                                    'لم تنجز بعد',
                                    const Icon(
                                      Icons.checklist,
                                      color: cyan500,
                                    ),
                                    Color.fromARGB(50, 41, 157, 144),
                                    cyan500,
                                    context),
                                _column(
                                    'in_progress',
                                    casesCubit,
                                    'قيد الإنجاز',
                                    const Icon(
                                      Icons.work_history_rounded,
                                      color: Color.fromARGB(91, 130, 99, 6),
                                    ),
                                    Color.fromARGB(50, 255, 193, 7),
                                    Color.fromARGB(91, 94, 72, 8),
                                    context),
                                _column(
                                  'pending',
                                  casesCubit,
                                  'بحاجة موافقة',
                                  const Icon(
                                    Icons.warning_rounded,
                                    color: redmid,
                                  ),
                                  Color.fromARGB(50, 255, 82, 82),
                                  redmid,
                                  context,
                                ),
                                // _columnEntity(),
                              ]),
                        )
                      : state == 'error'
                          ? Center(
                              child: Text(
                                  'لم يتم تحميل الحالات، تأكد من اتصال الانترنت'),
                            )
                          : state == 'cases_list_loading'
                              ? CircularProgressIndicator(
                                  color: cyan400,
                                )
                              : SizedBox(),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: floatButton(
                  icon: Icons.add,
                  onTap: () {
                    locator<NavigationService>().navigateTo(addCasePageRoute);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _column(String type, CasesCubit casesCubit, String title, Widget icon,
    Color color, Color secondaryColor, BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 4.8,
    // height: MediaQuery.of(context).size.height / 1.2,
    child: Column(
      children: [
        Container(
            clipBehavior: Clip.antiAlias,
            // width: 300,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(color: white, width: .1),
                color: color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),

            //width: 200,
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              casesCubit.casesList![type]!.length.toString(),
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(title),
                        ],
                      ),
                    ),
                    icon,
                  ]),
            )),
        SizedBox(
          height: 010,
        ),
        Expanded(
            child: ListView.separated(
          itemBuilder: (context, index) {
            return _itembuilder(index, type, casesCubit, context, icon, color);
          },
          itemCount: casesCubit.casesList![type]!.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
        ))
      ],
    ),
  );
}

Widget _itembuilder(
  int index,
  String type,
  CasesCubit cubit,
  context,
  Widget icon,
  Color color,
) {
  var info = cubit.casesList![type]![index];
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
    // decoration: BoxDecoration(
    //     backgroundBlendMode: BlendMode.clear,
    //     color: bglight,
    //     borderRadius: BorderRadius.only(
    //         topRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
      hoverColor: const Color.fromARGB(63, 48, 195, 178),
      onTap: () =>
          locator<NavigationService>().navigateTo(caseDetailsPageRoute),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: cyan50op,
                  border: Border.all(color: cyan100, width: .5)),
              child: DottedBorder(
                strokeWidth: .4,
                radius: Radius.circular(5),
                borderType: BorderType.RRect,
                color: cyan600,
                dashPattern: [7, 2],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        info.createdAt.toIso8601String(),
                        style: TextStyle(
                          color: cyan500,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        color: cyan500,
                        Icons.calendar_month_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                  color: cyan50op,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: cyan100, width: .5)),

              // border: Border.all(color: cyan200, width: .5),

              child: DottedBorder(
                strokeWidth: .4,
                radius: Radius.circular(5),
                borderType: BorderType.RRect,
                color: cyan600,
                dashPattern: [7, 2],
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الطبيب: ${info.dentist.firstName} ${info.dentist.lastName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: cyan500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'المريض: ${info.patient.fullName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: cyan500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
