import 'package:lambda_dent_dash/data/models/employees/db_employees.dart';
import 'package:lambda_dent_dash/domain/models/employees/employees.dart';
import 'package:lambda_dent_dash/domain/repo/employees_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBEmployeesRepo extends EmployeesRepo {
  @override
  Future<EmployeesResponse?> getEmployees() async {
    try {
      final response = await DioHelper.getData(
        'lab-manager/employees/',
        token: CacheHelper.get('token'),
      );

      if (response?.data != null && response!.data['status'] == true) {
        final dbResponse = DBEmployeesResponse.fromJson(response.data);
        return _mapToDomain(dbResponse);
      } else {
        print(
            'Failed to get employees: ${response?.data['message'] ?? 'Unknown error'}');
        return null;
      }
    } catch (error) {
      print('Error getting employees: $error');
      return null;
    }
  }

  @override
  Future<bool> createEmployee({
    required String guard,
    required String fullName,
    required String email,
    required String phone,
    required String workStartAt,
  }) async {
    try {
      final response = await DioHelper.postData(
        'lab-manager/employees/create',
        {
          'guard': guard,
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'work_start_at': workStartAt,
        },
        token: CacheHelper.get('token'),
      );

      if (response?.data != null && response!.data['status'] == true) {
        return true;
      } else {
        print(
            'Failed to create employee: ${response?.data['message'] ?? 'Unknown error'}');
        return false;
      }
    } catch (error) {
      print('Error creating employee: $error');
      return false;
    }
  }

  EmployeesResponse _mapToDomain(DBEmployeesResponse dbResponse) {
    return EmployeesResponse(
      status: dbResponse.status,
      successCode: dbResponse.successCode,
      successMessage: dbResponse.successMessage,
      employees: dbResponse.employees != null
          ? _mapEmployeesToDomain(dbResponse.employees!)
          : null,
    );
  }

  Employees _mapEmployeesToDomain(DBEmployees dbEmployees) {
    return Employees(
      activeInventoryEmployee: dbEmployees.activeInventoryEmployee != null
          ? _mapEmployeeToDomain(dbEmployees.activeInventoryEmployee!)
          : null,
      inactiveInventoryEmployees: dbEmployees.inactiveInventoryEmployees
          ?.map((e) => _mapEmployeeToDomain(e))
          .toList(),
      activeAccountant: dbEmployees.activeAccountant != null
          ? _mapEmployeeToDomain(dbEmployees.activeAccountant!)
          : null,
      inactiveAccountants: dbEmployees.inactiveAccountants
          ?.map((e) => _mapEmployeeToDomain(e))
          .toList(),
    );
  }

  Employee _mapEmployeeToDomain(DBEmployee dbEmployee) {
    return Employee(
      id: dbEmployee.id,
      fullName: dbEmployee.fullName,
      startAt: dbEmployee.startAt,
      email: dbEmployee.email,
      phone: dbEmployee.phone,
      terminationAt: dbEmployee.terminationAt,
    );
  }
}
