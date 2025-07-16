class PreviewBillPatient {
  final int id;
  final String fullName;

  PreviewBillPatient({required this.id, required this.fullName});

  factory PreviewBillPatient.fromJson(Map<String, dynamic> json) {
    return PreviewBillPatient(
      id: json['id'],
      fullName: json['full_name'],
    );
  }
}

class PreviewBillMedicalCase {
  final int id;
  final int patientId;
  final int dentistId;
  final int labManagerId;
  final String expectedDeliveryDate;
  final int status;
  final int cost;
  final String createdAt;
  final PreviewBillPatient patient;

  PreviewBillMedicalCase({
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

  factory PreviewBillMedicalCase.fromJson(Map<String, dynamic> json) {
    return PreviewBillMedicalCase(
      id: json['id'],
      patientId: json['patient_id'],
      dentistId: json['dentist_id'],
      labManagerId: json['lab_manager_id'],
      expectedDeliveryDate: json['expected_delivery_date'],
      status: json['status'],
      cost: json['cost'],
      createdAt: json['created_at'],
      patient: PreviewBillPatient.fromJson(json['patient']),
    );
  }
}

class PreviewBillPreview {
  final List<PreviewBillMedicalCase> medicalCases;
  final int totalBillCost;

  PreviewBillPreview({required this.medicalCases, required this.totalBillCost});

  factory PreviewBillPreview.fromJson(Map<String, dynamic> json) {
    return PreviewBillPreview(
      medicalCases: (json['medical_cases'] as List)
          .map((e) => PreviewBillMedicalCase.fromJson(e))
          .toList(),
      totalBillCost: json['total_bill_cost'],
    );
  }
}

class PreviewBillResponse {
  final bool status;
  final int successCode;
  final PreviewBillPreview preview;
  final String successMessage;

  PreviewBillResponse({
    required this.status,
    required this.successCode,
    required this.preview,
    required this.successMessage,
  });

  factory PreviewBillResponse.fromJson(Map<String, dynamic> json) {
    return PreviewBillResponse(
      status: json['status'],
      successCode: json['success_code'],
      preview: PreviewBillPreview.fromJson(json['preview']),
      successMessage: json['success_message'],
    );
  }
}
