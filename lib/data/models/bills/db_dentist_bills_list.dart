import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';

class DBDentistBillsListResponse {
  bool? status;
  int? successCode;
  List<DBDentistBillInList>? bills;
  DBDentist? dentist;
  DBDentistCurrentBalance? currentBalance;
  String? successMessage;

  DBDentistBillsListResponse({
    this.status,
    this.successCode,
    this.bills,
    this.dentist,
    this.currentBalance,
    this.successMessage,
  });

  DBDentistBillsListResponse.fromJson(Map<String, dynamic> json) {
    final dentistBills =
        json['dentist_bills'] ?? json['dentist_bills']['dentist_bills'];
    status = json['status'];
    successCode = json['success_code'];
    bills = (dentistBills as List?)
        ?.map((i) => DBDentistBillInList.fromJson(i))
        .toList();
    dentist = DBDentist.fromJson(json['dentist_bills']['dentist']);
    currentBalance = DBDentistCurrentBalance.fromJson(
        json['dentist_bills']['dentist_current_balance']);
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (bills != null)
      data['dentist_bills'] = bills!.map((e) => e.toJson()).toList();
    if (dentist != null) data['dentist'] = dentist!.toJson();
    if (currentBalance != null)
      data['dentist_current_balance'] = currentBalance!.toJson();
    data['success_message'] = successMessage;
    return data;
  }
}

class DBDentistBillInList {
  final int id;
  final String billNumber;
  final int totalCost;
  final DateTime createdAt;

  DBDentistBillInList({
    required this.id,
    required this.billNumber,
    required this.totalCost,
    required this.createdAt,
  });

  factory DBDentistBillInList.fromJson(Map<String, dynamic> json) {
    return DBDentistBillInList(
      id: json['id'],
      billNumber: json['bill_number'],
      totalCost: json['total_cost'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bill_number': billNumber,
      'total_cost': totalCost,
      'created_at': createdAt.toIso8601String(),
    };
  }

  DentistBillInList toDomain() {
    return DentistBillInList(
      id: id,
      billNumber: billNumber,
      totalCost: totalCost,
      createdAt: createdAt,
    );
  }

  static DBDentistBillInList fromDomain(DentistBillInList bill) {
    return DBDentistBillInList(
      id: bill.id,
      billNumber: bill.billNumber,
      totalCost: bill.totalCost,
      createdAt: bill.createdAt,
    );
  }
}

class DBDentist {
  final int id;
  final String firstName;
  final String lastName;
  final int phone;
  final String address;

  DBDentist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  factory DBDentist.fromJson(Map<String, dynamic> json) {
    return DBDentist(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'address': address,
    };
  }

  DentistinBill toDomain() {
    return DentistinBill(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
    );
  }

  static DBDentist fromDomain(DentistinBill dentist) {
    return DBDentist(
      id: dentist.id,
      firstName: dentist.firstName,
      lastName: dentist.lastName,
      phone: dentist.phone,
      address: dentist.address,
    );
  }
}

class DBDentistCurrentBalance {
  final int currentAccount;

  DBDentistCurrentBalance({required this.currentAccount});

  factory DBDentistCurrentBalance.fromJson(Map<String, dynamic> json) {
    return DBDentistCurrentBalance(
      currentAccount: json['current_account'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_account': currentAccount,
    };
  }

  DentistCurrentBalance toDomain() {
    return DentistCurrentBalance(currentAccount: currentAccount);
  }

  static DBDentistCurrentBalance fromDomain(DentistCurrentBalance balance) {
    return DBDentistCurrentBalance(currentAccount: balance.currentAccount);
  }
}
