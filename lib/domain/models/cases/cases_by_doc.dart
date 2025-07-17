class MedicalCasesForDentistResponse {
  final bool? status;
  final int? successCode;
  final MedicalCasesForDentist? medicalCasesForDentist;
  final String? successMessage;

  MedicalCasesForDentistResponse({
    this.status,
    this.successCode,
    this.medicalCasesForDentist,
    this.successMessage,
  });
}

class MedicalCasesForDentist {
  final Dentist? dentist;
  final DentistCurrentBalance? dentistCurrentBalance;
  final List<DentistCase> dentistCases;

  MedicalCasesForDentist({
    this.dentist,
    this.dentistCurrentBalance,
    required this.dentistCases,
  });
}

class Dentist {
  final int? id;
  final String? firstName;
  final String? lastName;
  final int? phone;
  final String? address;

  Dentist({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
  });
}

class DentistCurrentBalance {
  final int? currentAccount;

  DentistCurrentBalance({this.currentAccount});
}

class DentistCase {
  final int? id;
  final int? dentistId;
  final int? patientId;
  final String? expectedDeliveryDate;
  final String? status;
  final DateTime? createdAt;
  final Patient? patient;

  DentistCase({
    this.id,
    this.dentistId,
    this.patientId,
    this.expectedDeliveryDate,
    this.status,
    this.createdAt,
    this.patient,
  });
}

class Patient {
  final int? id;
  final String? fullName;

  Patient({
    this.id,
    this.fullName,
  });
}