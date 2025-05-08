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
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'person.png',
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 384,
                height: .3,
                color: cyan300,
              ),
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
              SizedBox(
                height: 5,
              ),
              Text(
                'تاريخ بدء العمل: 8/12/2024',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: bottomActionButtons(context),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 400,
                  height: MediaQuery.sizeOf(context).height / 3,
                  child: CustomScrollView(slivers: [
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
