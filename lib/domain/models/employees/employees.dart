class EmployeesResponse {
  final bool? status;
  final int? successCode;
  final Employees? employees;
  final String? successMessage;

  EmployeesResponse({
    this.status,
    this.successCode,
    this.employees,
    this.successMessage,
  });
}

class Employees {
  final Employee? activeInventoryEmployee;
  final List<Employee>? inactiveInventoryEmployees;
  final Employee? activeAccountant;
  final List<Employee>? inactiveAccountants;

  Employees({
    this.activeInventoryEmployee,
    this.inactiveInventoryEmployees,
    this.activeAccountant,
    this.inactiveAccountants,
  });
}

class Employee {
  final int? id;
  final String? fullName;
  final String? startAt;
  final String? email;
  final String? phone;
  final String? terminationAt;

  Employee({
    this.id,
    this.fullName,
    this.startAt,
    this.email,
    this.phone,
    this.terminationAt,
  });
}
