import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/employees/employees.dart';
import 'package:lambda_dent_dash/domain/repo/employees_repo.dart';
import 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(this.repo) : super(EmployeesInitial()) {
    getEmployees();
  }

  final EmployeesRepo repo;
  EmployeesResponse? employeesResponse;

  Future<void> getEmployees() async {
    emit(EmployeesLoading());
    try {
      employeesResponse = await repo.getEmployees();
      if (employeesResponse != null) {
        emit(EmployeesLoaded(employeesResponse!));
      } else {
        emit(EmployeesError('No employees found.'));
      }
    } on Exception catch (e) {
      emit(EmployeesError("Error loading employees: ${e.toString()}"));
    }
  }

  Future<bool> createEmployee({
    required String guard,
    required String fullName,
    required String email,
    required String phone,
    required String workStartAt,
  }) async {
    try {
      final success = await repo.createEmployee(
        guard: guard,
        fullName: fullName,
        email: email,
        phone: phone,
        workStartAt: workStartAt,
      );

      if (success) {
        // Refresh the employees list after successful creation
        await getEmployees();
        return true;
      } else {
        emit(EmployeesError('Failed to create employee.'));
        return false;
      }
    } on Exception catch (e) {
      emit(EmployeesError("Error creating employee: ${e.toString()}"));
      return false;
    }
  }

  // Helper methods to get specific employee data
  Employee? getActiveInventoryEmployee() {
    return employeesResponse?.employees?.activeInventoryEmployee;
  }

  Employee? getActiveAccountant() {
    return employeesResponse?.employees?.activeAccountant;
  }

  List<Employee> getInactiveInventoryEmployees() {
    return employeesResponse?.employees?.inactiveInventoryEmployees ?? [];
  }

  List<Employee> getInactiveAccountants() {
    return employeesResponse?.employees?.inactiveAccountants ?? [];
  }
}
