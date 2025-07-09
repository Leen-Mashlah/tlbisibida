import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';

class DBMedicalCasesForDentistResponse {
  bool? status;
  int? successCode;
  DBMedicalCasesForDentist? medicalCasesForDentist;
  String? successMessage;

  DBMedicalCasesForDentistResponse({
    this.status,
    this.successCode,
    this.medicalCasesForDentist,
    this.successMessage,
  });

  DBMedicalCasesForDentistResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    medicalCasesForDentist = json['medical_cases_for_dentist'] != null
        ? DBMedicalCasesForDentist.fromJson(json['medical_cases_for_dentist'])
        : null;
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (medicalCasesForDentist != null) {
      data['medical_cases_for_dentist'] = medicalCasesForDentist!.toJson();
    }
    data['success_message'] = successMessage;
    return data;
  }

  MedicalCasesForDentistResponse toDomain() {
    return MedicalCasesForDentistResponse(
      status: status,
      successCode: successCode,
      medicalCasesForDentist: medicalCasesForDentist?.toDomain(),
      successMessage: successMessage,
    );
  }
}

class DBMedicalCasesForDentist {
  DBDentist? dentist;
  DBDentistCurrentBalance? dentistCurrentBalance;
  List<DBDentistCase>? dentistCases;

  DBMedicalCasesForDentist({
    this.dentist,
    this.dentistCurrentBalance,
    this.dentistCases,
  });

  DBMedicalCasesForDentist.fromJson(Map<String, dynamic> json) {
    dentist =
        json['dentist'] != null ? DBDentist.fromJson(json['dentist']) : null;
    dentistCurrentBalance = json['dentist_current_balance'] != null
        ? DBDentistCurrentBalance.fromJson(json['dentist_current_balance'])
        : null;
    if (json['dentist_cases'] != null) {
      dentistCases = <DBDentistCase>[];
      json['dentist_cases'].forEach((v) {
        dentistCases!.add(DBDentistCase.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dentist != null) {
      data['dentist'] = dentist!.toJson();
    }
    if (dentistCurrentBalance != null) {
      data['dentist_current_balance'] = dentistCurrentBalance!.toJson();
    }
    if (dentistCases != null) {
      data['dentist_cases'] = dentistCases!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  MedicalCasesForDentist toDomain() {
    return MedicalCasesForDentist(
      dentist: dentist?.toDomain(),
      dentistCurrentBalance: dentistCurrentBalance?.toDomain(),
      dentistCases: dentistCases?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

class DBDentist {
  int? id;
  String? firstName;
  String? lastName;
  int? phone;
  String? address;

  DBDentist({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
  });

  DBDentist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }

  Dentist toDomain() {
    return Dentist(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
    );
  }
}

class DBDentistCurrentBalance {
  int? currentAccount;

  DBDentistCurrentBalance({this.currentAccount});

  DBDentistCurrentBalance.fromJson(Map<String, dynamic> json) {
    currentAccount = json['current_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_account'] = currentAccount;
    return data;
  }

  DentistCurrentBalance toDomain() {
    return DentistCurrentBalance(
      currentAccount: currentAccount,
    );
  }
}

class DBDentistCase {
  int? id;
  int? dentistId;
  int? patientId;
  String? expectedDeliveryDate;
  int? status;
  String? createdAt;
  DBPatient? patient;

  DBDentistCase({
    this.id,
    this.dentistId,
    this.patientId,
    this.expectedDeliveryDate,
    this.status,
    this.createdAt,
    this.patient,
  });

  DBDentistCase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dentistId = json['dentist_id'];
    patientId = json['patient_id'];
    expectedDeliveryDate = json['expected_delivery_date'];
    status = json['status'];
    createdAt = json['created_at'];
    patient =
        json['patient'] != null ? DBPatient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dentist_id'] = dentistId;
    data['patient_id'] = patientId;
    data['expected_delivery_date'] = expectedDeliveryDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    return data;
  }

  DentistCase toDomain() {
    return DentistCase(
      id: id,
      dentistId: dentistId,
      patientId: patientId,
      expectedDeliveryDate: expectedDeliveryDate,
      status: decodeStatus(status!),
      createdAt: DateTime.tryParse(createdAt ?? ''),
      patient: patient?.toDomain(),
    );
  }

  String decodeStatus(int status) {
    switch (status) {
      case 0:
        return 'الطلب';
      case 2:
        return 'تم التأكيد';
      case 3:
        return 'قيد الإنجاز';
      case 4:
        return 'جاهزة';
      case 5:
        return 'تم التسليم';
      default:
        return 'خطأ';
    }
  }
}

class DBPatient {
  int? id;
  String? fullName;

  DBPatient({this.id, this.fullName});

  DBPatient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    return data;
  }

  Patient toDomain() {
    return Patient(
      id: id,
      fullName: fullName,
    );
  }
}
