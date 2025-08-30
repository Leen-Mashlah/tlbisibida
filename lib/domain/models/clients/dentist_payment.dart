class DentistPayment {
  final int id;
  final int signedValue;
  final String createdAt;

  DentistPayment({
    required this.id,
    required this.signedValue,
    required this.createdAt,
  });
}

class DentistPaymentsResponse {
  final bool status;
  final int successCode;
  final List<DentistPayment> dentistPayments;
  final String successMessage;

  DentistPaymentsResponse({
    required this.status,
    required this.successCode,
    required this.dentistPayments,
    required this.successMessage,
  });
}
