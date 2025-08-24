class DBEmployeesResponse {
  final bool? status;
  final int? successCode;
  final DBEmployees? employees;
  final String? successMessage;

  DBEmployeesResponse({
    this.status,
    this.successCode,
    this.employees,
    this.successMessage,
  });

  factory DBEmployeesResponse.fromJson(Map<String, dynamic> json) {
    return DBEmployeesResponse(
      status: json['status'],
      successCode: json['success_code'],
      employees: json['employees'] != null
          ? DBEmployees.fromJson(json['employees'])
          : null,
      successMessage: json['success_message'],
    );
  }
}

class DBEmployees {
  final DBEmployee? activeInventoryEmployee;
  final List<DBEmployee>? inactiveInventoryEmployees;
  final DBEmployee? activeAccountant;
  final List<DBEmployee>? inactiveAccountants;

  DBEmployees({
    this.activeInventoryEmployee,
    this.inactiveInventoryEmployees,
    this.activeAccountant,
    this.inactiveAccountants,
  });

  factory DBEmployees.fromJson(Map<String, dynamic> json) {
    return DBEmployees(
      activeInventoryEmployee: json['active_inventory_employee'] != null
          ? DBEmployee.fromJson(json['active_inventory_employee'])
          : null,
      inactiveInventoryEmployees: json['inactive_inventory_employees'] != null
          ? List<DBEmployee>.from(json['inactive_inventory_employees']
              .map((x) => DBEmployee.fromJson(x)))
          : null,
      activeAccountant: json['active_accountant'] != null
          ? DBEmployee.fromJson(json['active_accountant'])
          : null,
      inactiveAccountants: json['inactive_accountants'] != null
          ? List<DBEmployee>.from(
              json['inactive_accountants'].map((x) => DBEmployee.fromJson(x)))
          : null,
    );
  }
}

class DBEmployee {
  final int? id;
  final String? fullName;
  final String? startAt;
  final String? email;
  final String? phone;
  final String? terminationAt;

  DBEmployee({
    this.id,
    this.fullName,
    this.startAt,
    this.email,
    this.phone,
    this.terminationAt,
  });

  factory DBEmployee.fromJson(Map<String, dynamic> json) {
    return DBEmployee(
      id: json['id'],
      fullName: json['full_name'],
      startAt: json['start_at'],
      email: json['email'],
      phone: json['phone'],
      terminationAt: json['termination_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'start_at': startAt,
      'email': email,
      'phone': phone,
      'termination_at': terminationAt,
    };
  }
}
