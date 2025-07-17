class DentistBillsList {
  final List<DentistBillInList> bills;
  final DentistinBill dentist;
  final DentistCurrentBalance currentBalance;
  final bool status;
  final int successCode;
  final String successMessage;

  DentistBillsList({
    required this.bills,
    required this.dentist,
    required this.currentBalance,
    required this.status,
    required this.successCode,
    required this.successMessage,
  });

  factory DentistBillsList.fromJson(Map<String, dynamic> json) {
    final dentistBills =
        json['dentist_bills'] ?? json['dentist_bills']['dentist_bills'];
    return DentistBillsList(
      bills: (dentistBills as List)
          .map((i) => DentistBillInList.fromJson(i))
          .toList(),
      dentist: DentistinBill.fromJson(json['dentist_bills']['dentist']),
      currentBalance: DentistCurrentBalance.fromJson(
          json['dentist_bills']['dentist_current_balance']),
      status: json['status'],
      successCode: json['success_code'],
      successMessage: json['success_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dentist_bills': bills.map((e) => e.toJson()).toList(),
      'dentist': dentist.toJson(),
      'dentist_current_balance': currentBalance.toJson(),
      'status': status,
      'success_code': successCode,
      'success_message': successMessage,
    };
  }
}

class DentistBillInList {
  final int id;
  final String billNumber;
  final int totalCost;
  final DateTime createdAt;

  DentistBillInList({
    required this.id,
    required this.billNumber,
    required this.totalCost,
    required this.createdAt,
  });

  factory DentistBillInList.fromJson(Map<String, dynamic> json) {
    return DentistBillInList(
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
}

class DentistinBill {
  final int id;
  final String firstName;
  final String lastName;
  final int phone;
  final String address;

  DentistinBill({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  factory DentistinBill.fromJson(Map<String, dynamic> json) {
    return DentistinBill(
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
}

class DentistCurrentBalance {
  final int currentAccount;

  DentistCurrentBalance({required this.currentAccount});

  factory DentistCurrentBalance.fromJson(Map<String, dynamic> json) {
    return DentistCurrentBalance(
      currentAccount: json['current_account'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_account': currentAccount,
    };
  }
}
