class DBPreviewBillPatient {
  final int id;
  final String fullName;

  DBPreviewBillPatient({required this.id, required this.fullName});

  factory DBPreviewBillPatient.fromJson(Map<String, dynamic> json) {
    return DBPreviewBillPatient(
      id: json['id'],
      fullName: json['full_name'],
    );
  }
}

class DBPreviewBillMedicalCase {
  final int id;
  final int patientId;
  final int dentistId;
  final int labManagerId;
  final String expectedDeliveryDate;
  final int status;
  final int cost;
  final String createdAt;
  final DBPreviewBillPatient patient;

  DBPreviewBillMedicalCase({
    required this.id,
    required this.patientId,
    required this.dentistId,
    required this.labManagerId,
    required this.expectedDeliveryDate,
    required this.status,
    required this.cost,
    required this.createdAt,
    required this.patient,
  });

  factory DBPreviewBillMedicalCase.fromJson(Map<String, dynamic> json) {
    return DBPreviewBillMedicalCase(
      id: json['id'],
      patientId: json['patient_id'],
      dentistId: json['dentist_id'],
      labManagerId: json['lab_manager_id'],
      expectedDeliveryDate: json['expected_delivery_date'],
      status: json['status'],
      cost: json['cost'],
      createdAt: json['created_at'],
      patient: DBPreviewBillPatient.fromJson(json['patient']),
    );
  }
}

class DBPreviewBillPreview {
  final List<DBPreviewBillMedicalCase> medicalCases;
  final int totalBillCost;

  DBPreviewBillPreview(
      {required this.medicalCases, required this.totalBillCost});

  factory DBPreviewBillPreview.fromJson(Map<String, dynamic> json) {
    return DBPreviewBillPreview(
      medicalCases: (json['medical_cases'] as List)
          .map((e) => DBPreviewBillMedicalCase.fromJson(e))
          .toList(),
      totalBillCost: json['total_bill_cost'],
    );
  }
}

class DBPreviewBillResponse {
  final bool status;
  final int successCode;
  final DBPreviewBillPreview preview;
  final String successMessage;

  DBPreviewBillResponse({
    required this.status,
    required this.successCode,
    required this.preview,
    required this.successMessage,
  });

  factory DBPreviewBillResponse.fromJson(Map<String, dynamic> json) {
    return DBPreviewBillResponse(
      status: json['status'],
      successCode: json['success_code'],
      preview: DBPreviewBillPreview.fromJson(json['preview']),
      successMessage: json['success_message'],
    );
  }
}
