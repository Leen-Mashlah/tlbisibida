import 'package:lambda_dent_dash/domain/models/clients/dentist_payment.dart';

class DBDentistPayment {
  final int id;
  final int signedValue;
  final String createdAt;

  DBDentistPayment({
    required this.id,
    required this.signedValue,
    required this.createdAt,
  });

  factory DBDentistPayment.fromJson(Map<String, dynamic> json) {
    return DBDentistPayment(
      id: json['id'] ?? 0,
      signedValue: json['signed_value'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }

  DentistPayment toDomain() {
    return DentistPayment(
      id: id,
      signedValue: signedValue,
      createdAt: createdAt,
    );
  }
}

class DBDentistPaymentsResponse {
  final bool status;
  final int successCode;
  final List<DBDentistPayment> dentistPayments;
  final String successMessage;

  DBDentistPaymentsResponse({
    required this.status,
    required this.successCode,
    required this.dentistPayments,
    required this.successMessage,
  });

  factory DBDentistPaymentsResponse.fromJson(Map<String, dynamic> json) {
    List<DBDentistPayment> payments = [];
    if (json['dentist_payments'] != null) {
      payments = (json['dentist_payments'] as List)
          .map((payment) => DBDentistPayment.fromJson(payment))
          .toList();
    }

    return DBDentistPaymentsResponse(
      status: json['status'] ?? false,
      successCode: json['success_code'] ?? 0,
      dentistPayments: payments,
      successMessage: json['success_message'] ?? '',
    );
  }

  DentistPaymentsResponse toDomain() {
    return DentistPaymentsResponse(
      status: status,
      successCode: successCode,
      dentistPayments: dentistPayments.map((p) => p.toDomain()).toList(),
      successMessage: successMessage,
    );
  }
}
