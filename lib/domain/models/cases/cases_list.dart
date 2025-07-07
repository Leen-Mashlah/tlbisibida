class MedicalCasesByType {
  final List<MedicalCaseinList> pendingCases;
  final List<MedicalCaseinList> acceptedCases;
  final List<MedicalCaseinList> inProgressCases;

  MedicalCasesByType({
    required this.pendingCases,
    required this.acceptedCases,
    required this.inProgressCases,
  });

  factory MedicalCasesByType.fromJson(Map<String, dynamic> json) {
    return MedicalCasesByType(
      pendingCases: (json['pending_cases_0'] as List)
          .map((i) => MedicalCaseinList.fromJson(i))
          .toList(),
      acceptedCases: (json['accepted_cases_1'] as List)
          .map((i) => MedicalCaseinList.fromJson(i))
          .toList(),
      inProgressCases: (json['in_progress_2'] as List)
          .map((i) => MedicalCaseinList.fromJson(i))
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

class MedicalCaseinList {
  final int id;
  final int dentistId;
  final int patientId;
  final DateTime createdAt;
  final Patient patient;
  final Dentist dentist;

  MedicalCaseinList({
    required this.id,
    required this.dentistId,
    required this.patientId,
    required this.createdAt,
    required this.patient,
    required this.dentist,
  });

  factory MedicalCaseinList.fromJson(Map<String, dynamic> json) {
    return MedicalCaseinList(
      id: json['id'],
      dentistId: json['dentist_id'],
      patientId: json['patient_id'],
      createdAt: DateTime.parse(json['created_at']),
      patient: Patient.fromJson(json['patient']),
      dentist: Dentist.fromJson(json['dentist']),
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
}

class Patient {
  final int id;
  final String fullName;

  Patient({
    required this.id,
    required this.fullName,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
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
}

class Dentist {
  final int id;
  final String firstName;
  final String lastName;

  Dentist({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Dentist.fromJson(Map<String, dynamic> json) {
    return Dentist(
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
}
