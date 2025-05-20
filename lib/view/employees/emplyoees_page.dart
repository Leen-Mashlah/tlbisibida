// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/employees/components/bottom_action_buttons.dart';
import 'package:lambda_dent_dash/view/employees/components/employee_log_table.dart';

class EmplyoeesPage extends StatelessWidget {
  const EmplyoeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 1.2,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 50,
          ),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) => employeeCard(context, index),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

Widget employeeCard(context, index) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width / 3.5,
    child: Card(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                'تحسين التحسيني',
                style: TextStyle(fontSize: 18, color: cyan500),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 250,
                height: .3,
                color: cyan300,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: cyan50op,
                    border: Border.all(width: .5, color: cyan200),
                    borderRadius: BorderRadius.circular(10)),
                width: 380,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.co_present_outlined,
                            size: 100,
                            color: cyan400,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Column(
                                children: [
                                  Text(
                                    'العنوان: شارع بغداد',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'الرقم: 0933225511',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: .5,
                                color: cyan400,
                                height: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Column(
                                children: [
                                  Text(
                                    'تاريخ بدء العمل: ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '8/12/2024',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: bottomActionButtons(context),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: 400,
                  height: MediaQuery.sizeOf(context).height / 2.6,
                  child: CustomScrollView(slivers: const [
                    SliverFillRemaining(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: EmployeeLogTable()),
                    ),
                  ])),
            ],
          ),
        )),
  );
}
