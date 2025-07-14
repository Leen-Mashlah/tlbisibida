import 'package:lambda_dent_dash/domain/models/bills/bills_list.dart';

class DBLabBillsListResponse {
  bool? status;
  int? successCode;
  List<DBBillInList>? bills;
  String? successMessage;

  DBLabBillsListResponse({
    this.status,
    this.successCode,
    this.bills,
    this.successMessage,
  });

  DBLabBillsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    bills = (json['lab_bills'] as List?)
        ?.map((i) => DBBillInList.fromJson(i))
        .toList();
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (bills != null)
      data['lab_bills'] = bills!.map((e) => e.toJson()).toList();
    data['success_message'] = successMessage;
    return data;
  }
}

class DBBillInList {
  final int id;
  final String billNumber;
  final int totalCost;
  final int dentistId;
  final DateTime createdAt;
  final DBDentist dentist;

  DBBillInList({
    required this.id,
    required this.billNumber,
    required this.totalCost,
    required this.dentistId,
    required this.createdAt,
    required this.dentist,
  });

  factory DBBillInList.fromJson(Map<String, dynamic> json) {
    return DBBillInList(
      id: json['id'],
      billNumber: json['bill_number'],
      totalCost: json['total_cost'],
      dentistId: json['dentist_id'],
      createdAt: DateTime.parse(json['created_at']),
      dentist: DBDentist.fromJson(json['dentist']),
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

  BillInList toDomain() {
    return BillInList(
      id: id,
      billNumber: billNumber,
      totalCost: totalCost,
      dentistId: dentistId,
      createdAt: createdAt,
      dentist: dentist.toDomain(),
    );
  }

  static DBBillInList fromDomain(BillInList bill) {
    return DBBillInList(
      id: bill.id,
      billNumber: bill.billNumber,
      totalCost: bill.totalCost,
      dentistId: bill.dentistId,
      createdAt: bill.createdAt,
      dentist: DBDentist.fromDomain(bill.dentist),
    );
  }
}

class DBDentist {
  final int id;
  final String firstName;
  final String lastName;

  DBDentist({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory DBDentist.fromJson(Map<String, dynamic> json) {
    return DBDentist(
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

  Dentist toDomain() {
    return Dentist(id: id, firstName: firstName, lastName: lastName);
  }

  static DBDentist fromDomain(Dentist dentist) {
    return DBDentist(
      id: dentist.id,
      firstName: dentist.firstName,
      lastName: dentist.lastName,
    );
  }
}
