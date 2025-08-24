import 'package:lambda_dent_dash/domain/models/employees/employees.dart';

abstract class EmployeesState {}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final EmployeesResponse employeesResponse;

  EmployeesLoaded(this.employeesResponse);
}

class EmployeesError extends EmployeesState {
  final String message;

  EmployeesError(this.message);
}
