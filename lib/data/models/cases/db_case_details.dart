import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';

class DBMedicalCaseDetailsResponse {
  bool? status;
  int? successCode;
  DBMedicalCase? medicalCase;
  String? successMessage;

  DBMedicalCaseDetailsResponse({
    this.status,
    this.successCode,
    this.medicalCase,
    this.successMessage,
  });

  DBMedicalCaseDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    medicalCase = json['medical_case'] != null
        ? DBMedicalCase.fromJson(json['medical_case'])
        : null;
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (medicalCase != null) {
      data['medical_case'] = medicalCase!.toJson();
    }
    data['success_message'] = successMessage;
    return data;
  }
}

class DBMedicalCase {
  DBMedicalCaseDetails? medicalCaseDetails;
  String? patientFullName;
  String? patientGender;
  String? dentistFirstName;
  String? dentistLastName;
  List<DBMedicalCaseFile>? medicalCaseFiles;

  DBMedicalCase({
    this.medicalCaseDetails,
    this.patientFullName,
    this.patientGender,
    this.dentistFirstName,
    this.dentistLastName,
    this.medicalCaseFiles,
  });

  DBMedicalCase.fromJson(Map<String, dynamic> json) {
    medicalCaseDetails = json['medical_case_details'] != null
        ? DBMedicalCaseDetails.fromJson(json['medical_case_details'])
        : null;
    patientFullName = json['patient_full_name'];
    patientGender = json['patient_gender'];
    dentistFirstName = json['dentist_first_name'];
    dentistLastName = json['dentist_last_name'];
    if (json['medical_case_files'] != null) {
      medicalCaseFiles = <DBMedicalCaseFile>[];
      json['medical_case_files'].forEach((v) {
        medicalCaseFiles!.add(DBMedicalCaseFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicalCaseDetails != null) {
      data['medical_case_details'] = medicalCaseDetails!.toJson();
    }
    data['patient_full_name'] = patientFullName;
    data['patient_gender'] = patientGender;
    data['dentist_first_name'] = dentistFirstName;
    data['dentist_last_name'] = dentistLastName;
    if (medicalCaseFiles != null) {
      data['medical_case_files'] =
          medicalCaseFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Assuming a domain model `MedicalCase` exists
  MedicalCase toDomain() {
    return MedicalCase(
      medicalCaseDetails: medicalCaseDetails?.toDomain(),
      patientFullName: patientFullName,
      patientGender: patientGender,
      dentistFirstName: dentistFirstName,
      dentistLastName: dentistLastName,
      medicalCaseFiles:
          medicalCaseFiles?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

class DBMedicalCaseDetails {
  int? id;
  int? dentistId;
  int? labManagerId;
  int? patientId;
  String? age;
  int? needTrial;
  int? repeat;
  String? shade;
  String? expectedDeliveryDate;
  String? notes;
  int? status;
  int? confirmDelivery;
  int? cost;
  String? teethCrown;
  String? teethPontic;
  String? teethImplant;
  String? teethVeneer;
  String? teethInlay;
  String? teethDenture;
  String? bridgesCrown;
  String? bridgesPontic;
  String? bridgesImplant;
  String? bridgesVeneer;
  String? bridgesInlay;
  String? bridgesDenture;
  String? createdAt;
  String? updatedAt;

  DBMedicalCaseDetails({
    this.id,
    this.dentistId,
    this.labManagerId,
    this.patientId,
    this.age,
    this.needTrial,
    this.repeat,
    this.shade,
    this.expectedDeliveryDate,
    this.notes,
    this.status,
    this.confirmDelivery,
    this.cost,
    this.teethCrown,
    this.teethPontic,
    this.teethImplant,
    this.teethVeneer,
    this.teethInlay,
    this.teethDenture,
    this.bridgesCrown,
    this.bridgesPontic,
    this.bridgesImplant,
    this.bridgesVeneer,
    this.bridgesInlay,
    this.bridgesDenture,
    this.createdAt,
    this.updatedAt,
  });

  DBMedicalCaseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dentistId = json['dentist_id'];
    labManagerId = json['lab_manager_id'];
    patientId = json['patient_id'];
    age = json['age'];
    needTrial = json['need_trial'];
    repeat = json['repeat'];
    shade = json['shade'];
    expectedDeliveryDate = json['expected_delivery_date'];
    notes = json['notes'];
    status = json['status'];
    confirmDelivery = json['confirm_delivery'];
    cost = json['cost'];
    teethCrown = json['teeth_crown'];
    teethPontic = json['teeth_pontic'];
    teethImplant = json['teeth_implant'];
    teethVeneer = json['teeth_veneer'];
    teethInlay = json['teeth_inlay'];
    teethDenture = json['teeth_denture'];
    bridgesCrown = json['bridges_crown'];
    bridgesPontic = json['bridges_pontic'];
    bridgesImplant = json['bridges_implant'];
    bridgesVeneer = json['bridges_veneer'];
    bridgesInlay = json['bridges_inlay'];
    bridgesDenture = json['bridges_denture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dentist_id'] = dentistId;
    data['lab_manager_id'] = labManagerId;
    data['patient_id'] = patientId;
    data['age'] = age;
    data['need_trial'] = needTrial;
    data['repeat'] = repeat;
    data['shade'] = shade;
    data['expected_delivery_date'] = expectedDeliveryDate;
    data['notes'] = notes;
    data['status'] = status;
    data['confirm_delivery'] = confirmDelivery;
    data['cost'] = cost;
    data['teeth_crown'] = teethCrown;
    data['teeth_pontic'] = teethPontic;
    data['teeth_implant'] = teethImplant;
    data['teeth_veneer'] = teethVeneer;
    data['teeth_inlay'] = teethInlay;
    data['teeth_denture'] = teethDenture;
    data['bridges_crown'] = bridgesCrown;
    data['bridges_pontic'] = bridgesPontic;
    data['bridges_implant'] = bridgesImplant;
    data['bridges_veneer'] = bridgesVeneer;
    data['bridges_inlay'] = bridgesInlay;
    data['bridges_denture'] = bridgesDenture;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // Assuming a domain model `MedicalCaseDetails` exists
  MedicalCaseDetails toDomain() {
    return MedicalCaseDetails(
      id: id,
      dentistId: dentistId,
      labManagerId: labManagerId,
      patientId: patientId,
      age: age,
      needTrial: needTrial == 1 ? true : false,
      repeat: repeat == 1 ? true : false,
      shade: shade,
      expectedDeliveryDate: expectedDeliveryDate,
      notes: notes,
      status: status,
      confirmDelivery: confirmDelivery,
      cost: cost,
      teethCrown: teethCrown,
      teethPontic: teethPontic,
      teethImplant: teethImplant,
      teethVeneer: teethVeneer,
      teethInlay: teethInlay,
      teethDenture: teethDenture,
      bridgesCrown: bridgesCrown,
      bridgesPontic: bridgesPontic,
      bridgesImplant: bridgesImplant,
      bridgesVeneer: bridgesVeneer,
      bridgesInlay: bridgesInlay,
      bridgesDenture: bridgesDenture,
      createdAt: DateTime.tryParse(createdAt ?? ''),
      updatedAt: DateTime.tryParse(updatedAt ?? ''),
    );
  }
}

class DBMedicalCaseFile {
  int? id;
  int? medicalCaseId;
  String? name;
  int? isCaseImage;
  String? createdAt;
  String? updatedAt;

  DBMedicalCaseFile({
    this.id,
    this.medicalCaseId,
    this.name,
    this.isCaseImage,
    this.createdAt,
    this.updatedAt,
  });

  DBMedicalCaseFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicalCaseId = json['medical_case_id'];
    name = json['name'];
    isCaseImage = json['is_case_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medical_case_id'] = medicalCaseId;
    data['name'] = name;
    data['is_case_image'] = isCaseImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // Assuming a domain model `MedicalCaseFile` exists
  MedicalCaseFile toDomain() {
    return MedicalCaseFile(
      id: id,
      medicalCaseId: medicalCaseId,
      name: name,
      isCaseImage: isCaseImage,
      createdAt: DateTime.tryParse(createdAt ?? ''),
      updatedAt: DateTime.tryParse(updatedAt ?? ''),
    );
  }
}

// Dummy Domain Models (replace with your actual domain models)

