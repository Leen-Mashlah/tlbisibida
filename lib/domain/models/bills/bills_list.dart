class LabBillsList {
  final List<BillInList> bills;
  final bool status;
  final int successCode;
  final String successMessage;

  LabBillsList({
    required this.bills,
    required this.status,
    required this.successCode,
    required this.successMessage,
  });

  factory LabBillsList.fromJson(Map<String, dynamic> json) {
    return LabBillsList(
      bills: (json['lab_bills'] as List)
          .map((i) => BillInList.fromJson(i))
          .toList(),
      status: json['status'],
      successCode: json['success_code'],
      successMessage: json['success_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lab_bills': bills.map((e) => e.toJson()).toList(),
      'status': status,
      'success_code': successCode,
      'success_message': successMessage,
    };
  }
}

class BillInList {
  final int id;
  final String billNumber;
  final int totalCost;
  final int dentistId;
  final DateTime createdAt;
  final Dentist dentist;

  BillInList({
    required this.id,
    required this.billNumber,
    required this.totalCost,
    required this.dentistId,
    required this.createdAt,
    required this.dentist,
  });

  factory BillInList.fromJson(Map<String, dynamic> json) {
    return BillInList(
      id: json['id'],
      billNumber: json['bill_number'],
      totalCost: json['total_cost'],
      dentistId: json['dentist_id'],
      createdAt: DateTime.parse(json['created_at']),
      dentist: Dentist.fromJson(json['dentist']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bill_number': billNumber,
      'total_cost': totalCost,
      'dentist_id': dentistId,
      'created_at': createdAt.toIso8601String(),
      'dentist': dentist.toJson(),
    };
  }
}

class Dentist {
  final int id;
  final String firstName;
  final String lastName;

  Dentist({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Dentist.fromJson(Map<String, dynamic> json) {
    return Dentist(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}
