class BillDetailsBillItem {
  final int id;
  final int dentistId;
  final int labManagerId;
  final String billNumber;
  final int totalCost;
  final String dateFrom;
  final String dateTo;
  final String createdAt;

  BillDetailsBillItem({
    required this.id,
    required this.dentistId,
    required this.labManagerId,
    required this.billNumber,
    required this.totalCost,
    required this.dateFrom,
    required this.dateTo,
    required this.createdAt,
  });
}

class BillDetailsPatient {
  final int id;
  final String fullName;
  BillDetailsPatient({required this.id, required this.fullName});
}

class BillDetailsMedicalCase {
  final int id;
  final int patientId;
  final int cost;
  final String createdAt;
  final BillDetailsPatient patient;

  BillDetailsMedicalCase({
    required this.id,
    required this.patientId,
    required this.cost,
    required this.createdAt,
    required this.patient,
  });
}

class BillDetailsBillCase {
  final int id;
  final int billId;
  final int medicalCaseId;
  final int caseCost;
  final String createdAt;
  final String updatedAt;
  final BillDetailsMedicalCase medicalCase;

  BillDetailsBillCase({
    required this.id,
    required this.billId,
    required this.medicalCaseId,
    required this.caseCost,
    required this.createdAt,
    required this.updatedAt,
    required this.medicalCase,
  });
}

class BillDetailsData {
  final List<BillDetailsBillItem> bill;
  final List<BillDetailsBillCase> billCases;

  BillDetailsData({required this.bill, required this.billCases});
}

class BillDetailsResponse {
  final bool status;
  final int successCode;
  final BillDetailsData data;
  final String successMessage;

  BillDetailsResponse({
    required this.status,
    required this.successCode,
    required this.data,
    required this.successMessage,
  });
}
