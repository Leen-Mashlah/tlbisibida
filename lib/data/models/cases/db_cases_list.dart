import 'package:lambda_dent_dash/domain/models/cases/cases_list.dart';

class DBMedicalCasesByTypeResponse {
  bool? status;
  int? successCode;
  DBMedicalCasesByType? medicalCasesByType;
  String? successMessage;

  DBMedicalCasesByTypeResponse({
    this.status,
    this.successCode,
    this.medicalCasesByType,
    this.successMessage,
  });

  DBMedicalCasesByTypeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    medicalCasesByType =
        DBMedicalCasesByType.fromJson(json['medical_cases_by_type']);
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (medicalCasesByType != null) data['medical_cases_by_type'];
    data['success_message'] = successMessage;
    return data;
  }
}

class DBMedicalCasesByType {
  final List<DBMedicalCase> pendingCases;
  final List<DBMedicalCase> acceptedCases;
  final List<DBMedicalCase> inProgressCases;

  DBMedicalCasesByType({
    required this.pendingCases,
    required this.acceptedCases,
    required this.inProgressCases,
  });

  factory DBMedicalCasesByType.fromJson(Map<String, dynamic> json) {
    return DBMedicalCasesByType(
      pendingCases: (json['pending_cases_0'] as List)
          .map((i) => DBMedicalCase.fromJson(i))
          .toList(),
      acceptedCases: (json['accepted_cases_1'] as List)
          .map((i) => DBMedicalCase.fromJson(i))
          .toList(),
      inProgressCases: (json['in_progress_2'] as List)
          .map((i) => DBMedicalCase.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_cases_0': pendingCases.map((e) => e.toJson()).toList(),
      'accepted_cases_1': acceptedCases.map((e) => e.toJson()).toList(),
      'in_progress_2': inProgressCases.map((e) => e.toJson()).toList(),
    };
  }
}

class DBMedicalCase {
  final int id;
  final int dentistId;
  final int patientId;
  final DateTime createdAt;
  final DBPatient patient;
  final DBDentist dentist;

  DBMedicalCase({
    required this.id,
    required this.dentistId,
    required this.patientId,
    required this.createdAt,
    required this.patient,
    required this.dentist,
  });

  factory DBMedicalCase.fromJson(Map<String, dynamic> json) {
    return DBMedicalCase(
      id: json['id'],
      dentistId: json['dentist_id'],
      patientId: json['patient_id'],
      createdAt: DateTime.parse(json['created_at']),
      patient: DBPatient.fromJson(json['patient']),
      dentist: DBDentist.fromJson(json['dentist']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dentist_id': dentistId,
      'patient_id': patientId,
      'created_at': createdAt.toIso8601String(),
      'patient': patient.toJson(),
      'dentist': dentist.toJson(),
    };
  }

  MedicalCaseinList todomain() {
    return MedicalCaseinList(
        id: id,
        dentistId: dentistId,
        patientId: patientId,
        createdAt: createdAt,
        patient: patient.todomain(),
        dentist: dentist.toDomain());
  }

  static DBMedicalCase fromdomain(MedicalCaseinList medcase) {
    return DBMedicalCase(
        id: medcase.id,
        dentistId: medcase.dentistId,
        patientId: medcase.patientId,
        createdAt: medcase.createdAt,
        patient: DBPatient.fromdomain(medcase.patient),
        dentist: DBDentist.fromDomain(medcase.dentist));
  }
}

class DBPatient {
  final int id;
  final String fullName;

  DBPatient({
    required this.id,
    required this.fullName,
  });

  factory DBPatient.fromJson(Map<String, dynamic> json) {
    return DBPatient(
      id: json['id'],
      fullName: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
    };
  }

  Patient todomain() {
    return Patient(id: id, fullName: fullName);
  }

  static DBPatient fromdomain(Patient patient) {
    return DBPatient(id: patient.id, fullName: patient.fullName);
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
    return Dentist(firstName: firstName, lastName: lastName, id: id);
  }

  static DBDentist fromDomain(Dentist dentist) {
    return DBDentist(
      id: dentist.id,
      firstName: dentist.firstName,
      lastName: dentist.lastName,
    );
  }
}
