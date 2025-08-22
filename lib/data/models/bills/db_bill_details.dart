import 'package:lambda_dent_dash/domain/models/bills/bill_details.dart';

class DBBillDetailsBillItem {
  final int id;
  final int dentistId;
  final int labManagerId;
  final String billNumber;
  final int totalCost;
  final String dateFrom;
  final String dateTo;
  final String createdAt;

  DBBillDetailsBillItem({
    required this.id,
    required this.dentistId,
    required this.labManagerId,
    required this.billNumber,
    required this.totalCost,
    required this.dateFrom,
    required this.dateTo,
    required this.createdAt,
  });

  factory DBBillDetailsBillItem.fromJson(Map<String, dynamic> json) {
    return DBBillDetailsBillItem(
      id: json['id'],
      dentistId: json['dentist_id'],
      labManagerId: json['lab_manager_id'],
      billNumber: json['bill_number'],
      totalCost: json['total_cost'],
      dateFrom: json['date_from'],
      dateTo: json['date_to'],
      createdAt: json['created_at'],
    );
  }

  BillDetailsBillItem toDomain() => BillDetailsBillItem(
        id: id,
        dentistId: dentistId,
        labManagerId: labManagerId,
        billNumber: billNumber,
        totalCost: totalCost,
        dateFrom: dateFrom,
        dateTo: dateTo,
        createdAt: createdAt,
      );
}

class DBBillDetailsPatient {
  final int id;
  final String fullName;
  DBBillDetailsPatient({required this.id, required this.fullName});
  factory DBBillDetailsPatient.fromJson(Map<String, dynamic> json) =>
      DBBillDetailsPatient(id: json['id'], fullName: json['full_name']);
  BillDetailsPatient toDomain() =>
      BillDetailsPatient(id: id, fullName: fullName);
}

class DBBillDetailsMedicalCase {
  final int id;
  final int patientId;
  final int cost;
  final String createdAt;
  final DBBillDetailsPatient patient;

  DBBillDetailsMedicalCase({
    required this.id,
    required this.patientId,
    required this.cost,
    required this.createdAt,
    required this.patient,
  });

  factory DBBillDetailsMedicalCase.fromJson(Map<String, dynamic> json) =>
      DBBillDetailsMedicalCase(
        id: json['id'],
        patientId: json['patient_id'],
        cost: json['cost'],
        createdAt: json['created_at'],
        patient: DBBillDetailsPatient.fromJson(json['patient']),
      );

  BillDetailsMedicalCase toDomain() => BillDetailsMedicalCase(
        id: id,
        patientId: patientId,
        cost: cost,
        createdAt: createdAt,
        patient: patient.toDomain(),
      );
}

class DBBillDetailsBillCase {
  final int id;
  final int billId;
  final int medicalCaseId;
  final int caseCost;
  final String createdAt;
  final String updatedAt;
  final DBBillDetailsMedicalCase medicalCase;

  DBBillDetailsBillCase({
    required this.id,
    required this.billId,
    required this.medicalCaseId,
    required this.caseCost,
    required this.createdAt,
    required this.updatedAt,
    required this.medicalCase,
  });

  factory DBBillDetailsBillCase.fromJson(Map<String, dynamic> json) =>
      DBBillDetailsBillCase(
        id: json['id'],
        billId: json['bill_id'],
        medicalCaseId: json['medical_case_id'],
        caseCost: json['case_cost'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        medicalCase: DBBillDetailsMedicalCase.fromJson(json['medical_case']),
      );

  BillDetailsBillCase toDomain() => BillDetailsBillCase(
        id: id,
        billId: billId,
        medicalCaseId: medicalCaseId,
        caseCost: caseCost,
        createdAt: createdAt,
        updatedAt: updatedAt,
        medicalCase: medicalCase.toDomain(),
      );
}

class DBBillDetailsData {
  final List<DBBillDetailsBillItem> bill;
  final List<DBBillDetailsBillCase> billCases;

  DBBillDetailsData({required this.bill, required this.billCases});

  factory DBBillDetailsData.fromJson(Map<String, dynamic> json) =>
      DBBillDetailsData(
        bill: (json['bill'] as List)
            .map((e) => DBBillDetailsBillItem.fromJson(e))
            .toList(),
        billCases: (json['bill_cases'] as List)
            .map((e) => DBBillDetailsBillCase.fromJson(e))
            .toList(),
      );

  BillDetailsData toDomain() => BillDetailsData(
        bill: bill.map((e) => e.toDomain()).toList(),
        billCases: billCases.map((e) => e.toDomain()).toList(),
      );
}

class DBBillDetailsResponse {
  final bool status;
  final int successCode;
  final DBBillDetailsData data;
  final String successMessage;

  DBBillDetailsResponse({
    required this.status,
    required this.successCode,
    required this.data,
    required this.successMessage,
  });

  factory DBBillDetailsResponse.fromJson(Map<String, dynamic> json) =>
      DBBillDetailsResponse(
        status: json['status'],
        successCode: json['success_code'],
        data: DBBillDetailsData.fromJson(json['bill']),
        successMessage: json['success_message'],
      );

  BillDetailsResponse toDomain() => BillDetailsResponse(
        status: status,
        successCode: successCode,
        data: data.toDomain(),
        successMessage: successMessage,
      );
}
