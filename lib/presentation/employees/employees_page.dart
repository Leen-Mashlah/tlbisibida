// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/float_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/employees/employees.dart';
import 'package:lambda_dent_dash/presentation/employees/components/Dialogs/employee_add_dialog.dart';
import 'package:lambda_dent_dash/presentation/employees/components/bottom_action_buttons.dart';
import 'package:lambda_dent_dash/presentation/employees/components/employee_log_table.dart';
import 'package:lambda_dent_dash/presentation/employees/Cubits/employees_cubit.dart';
import 'package:lambda_dent_dash/presentation/employees/Cubits/employees_state.dart';

class EmplyoeesPage extends StatelessWidget {
  const EmplyoeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state is EmployeesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (state is EmployeesLoading)
                const Center(child: CircularProgressIndicator())
              else if (state is EmployeesLoaded)
                Center(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.2,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 50,
                      ),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) => employeeCard(
                          context, index, state.employeesResponse.employees!),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                )
              else if (state is EmployeesError)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red),
                      SizedBox(height: 20),
                      Text(
                        'Error: ${state.message}',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<EmployeesCubit>().getEmployees(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              else
                const Center(child: Text('No data available')),
              Positioned(
                bottom: 20,
                right: 20,
                child: floatButton(
                  icon: Icons.add,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return employeeAddDialog(
                          context,
                          context.read<EmployeesCubit>(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget employeeCard(BuildContext context, int index, Employees employees) {
  // Determine which employee data to show based on index
  Employee? activeEmployee;
  String roleTitle;
  String employeeType;

  if (index == 0) {
    // Inventory Manager
    activeEmployee = employees.activeInventoryEmployee;
    roleTitle = 'مدير المخزون';
    employeeType = 'inventory';
  } else {
    // Accountant
    activeEmployee = employees.activeAccountant;
    roleTitle = 'محاسب';
    employeeType = 'accountant';
  }

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
                roleTitle,
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
                width: 580,
                height: 255,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          if (activeEmployee != null) ...[
                            Text(
                              activeEmployee.fullName ?? 'غير محدد',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: cyan600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Icon(
                              Icons.co_present_outlined,
                              size: 30,
                              color: cyan400,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'رقم الهاتف',
                                      style: TextStyle(
                                          fontSize: 14, color: cyan600),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      activeEmployee.phone ?? 'غير محدد',
                                      style: TextStyle(
                                          fontSize: 14, color: cyan600),
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
                                Column(
                                  children: [
                                    const Text(
                                      'تاريخ بدء العمل: ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      activeEmployee.startAt ?? 'غير محدد',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'البريد الإلكتروني',
                              style: TextStyle(fontSize: 12, color: cyan500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              activeEmployee.email ?? 'غير محدد',
                              style:
                                  const TextStyle(fontSize: 12, color: cyan500),
                            ),
                          ] else ...[
                            Column(
                              children: [
                                Icon(Icons.person_off,
                                    size: 64, color: Colors.grey),
                                SizedBox(height: 20),
                                Text(
                                  'لا يوجد موظف نشط',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (activeEmployee != null)
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
                  width: 500,
                  height: MediaQuery.sizeOf(context).height / 2.6,
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 4.0),
                          child: EmployeeLogTable(employeeType: employeeType)),
                    ),
                  ])),
            ],
          ),
        )),
  );
}
