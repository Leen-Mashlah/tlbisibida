import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/employees/employees.dart';
import 'package:lambda_dent_dash/presentation/employees/Cubits/employees_cubit.dart';
import 'package:lambda_dent_dash/presentation/employees/Cubits/employees_state.dart';

class EmployeeLogTable extends StatelessWidget {
  final String employeeType; // 'inventory' or 'accountant'

  const EmployeeLogTable({
    super.key,
    required this.employeeType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesCubit, EmployeesState>(
      builder: (context, state) {
        if (state is EmployeesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EmployeesLoaded) {
          final employeesCubit = context.read<EmployeesCubit>();
          List<Employee> inactiveEmployees = employeeType == 'inventory'
              ? employeesCubit.getInactiveInventoryEmployees()
              : employeesCubit.getInactiveAccountants();

          if (inactiveEmployees.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد موظفين غير نشطين',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('الاسم')),
                DataColumn(label: Text('تاريخ البدء')),
                DataColumn(label: Text('تاريخ الانتهاء')),
              ],
              rows: inactiveEmployees.map((employee) {
                return DataRow(
                  cells: [
                    DataCell(Text(employee.fullName ?? 'غير محدد')),
                    DataCell(Text(employee.startAt ?? 'غير محدد')),
                    DataCell(Text(employee.terminationAt ?? 'غير محدد')),
                  ],
                );
              }).toList(),
            ),
          );
        } else if (state is EmployeesError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
