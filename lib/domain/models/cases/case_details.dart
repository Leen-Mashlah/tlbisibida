class MedicalCase {
  MedicalCaseDetails? medicalCaseDetails;
  String? patientFullName;
  String? patientGender;
  String? dentistFirstName;
  String? dentistLastName;
  List<MedicalCaseFile>? medicalCaseFiles;

  MedicalCase({
    this.medicalCaseDetails,
    this.patientFullName,
    this.patientGender,
    this.dentistFirstName,
    this.dentistLastName,
    this.medicalCaseFiles,
  });

  MedicalCase.fromJson(Map<String, dynamic> json) {
    medicalCaseDetails = json['medical_case_details'] != null
        ? MedicalCaseDetails.fromJson(json['medical_case_details'])
        : null;
    patientFullName = json['patient_full_name'];
    patientGender = json['patient_gender'];
    dentistFirstName = json['dentist_first_name'];
    dentistLastName = json['dentist_last_name'];
    if (json['medical_case_files'] != null) {
      medicalCaseFiles = <MedicalCaseFile>[];
      json['medical_case_files'].forEach((v) {
        medicalCaseFiles!.add(MedicalCaseFile.fromJson(v));
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
}

class MedicalCaseDetails {
  int? id;
  int? dentistId;
  int? labManagerId;
  int? patientId;
  String? age;
  bool? needTrial;
  bool? repeat;
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
  DateTime? createdAt;
  DateTime? updatedAt;

  MedicalCaseDetails({
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

  MedicalCaseDetails.fromJson(Map<String, dynamic> json) {
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
}

class MedicalCaseFile {
  int? id;
  int? medicalCaseId;
  String? name;
  int? isCaseImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  MedicalCaseFile({
    this.id,
    this.medicalCaseId,
    this.name,
    this.isCaseImage,
    this.createdAt,
    this.updatedAt,
  });

  MedicalCaseFile.fromJson(Map<String, dynamic> json) {
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
}
