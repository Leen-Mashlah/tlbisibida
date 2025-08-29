// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/float_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_state.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class CasesListPage extends StatelessWidget {
  const CasesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CasesCubit, CasesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          CasesCubit casesCubit = context.read<CasesCubit>();
          Widget body;
          if (state is CasesLoading) {
            body =
                const Center(child: CircularProgressIndicator(color: cyan400));
          } else if (state is CasesError) {
            body = const Center(
              child: Text('لم يتم تحميل الحالات، تأكد من اتصال الانترنت'),
            );
          } else if (state is CasesLoaded) {
            body = Padding(
              padding: const EdgeInsets.only(top: 75.0),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
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
                          const Color.fromARGB(50, 41, 157, 144),
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
                          const Color.fromARGB(50, 255, 193, 7),
                          const Color.fromARGB(91, 94, 72, 8),
                          context),
                      _column(
                        'pending',
                        casesCubit,
                        'بحاجة موافقة',
                        const Icon(
                          Icons.warning_rounded,
                          color: redmid,
                        ),
                        const Color.fromARGB(50, 255, 82, 82),
                        redmid,
                        context,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CasesInitial) {
            // Show loading when initializing
            body =
                const Center(child: CircularProgressIndicator(color: cyan400));
          } else {
            body = const SizedBox();
          }

          return Stack(
            children: [
              body,
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
  // Safe access to casesList with null safety
  final List cases = casesCubit.casesList?[type] ?? [];
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
                              cases.length.toString(),
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
            child: cases.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد حالات',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return _itembuilder(
                          index, type, casesCubit, context, icon, color);
                    },
                    itemCount: cases.length,
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
  // Safe access to casesList with null safety
  final list = cubit.casesList?[type] ?? [];
  if (index < 0 || index >= list.length) {
    return const SizedBox.shrink();
  }
  var info = list[index];
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
                        (info.createdAt != null)
                            ? (info.createdAt is DateTime
                                ? (info.createdAt as DateTime).toIso8601String()
                                : info.createdAt.toString())
                            : '-',
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
                            'الطبيب: '
                            '${(info.dentist?.firstName ?? '')} '
                            '${(info.dentist?.lastName ?? '')}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: cyan500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'المريض: ${info.patient?.fullName ?? '-'}',
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
