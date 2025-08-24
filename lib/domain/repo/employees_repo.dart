import 'package:lambda_dent_dash/domain/models/employees/employees.dart';

abstract class EmployeesRepo {
  Future<EmployeesResponse?> getEmployees();
  Future<bool> createEmployee({
    required String guard,
    required String fullName,
    required String email,
    required String phone,
    required String workStartAt,
  });
}
