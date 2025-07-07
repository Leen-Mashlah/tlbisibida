import 'package:lambda_dent_dash/domain/repo/lapphone_chat.dart';

class LabManagerProfileResponse {
  bool? status;
  int? successCode;
  LabProfile? profile;
  String? successMessage;

  LabManagerProfileResponse(
      {this.status, this.successCode, this.profile, this.successMessage});

  LabManagerProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    profile =
        json['profile'] != null ? LabProfile.fromJson(json['profile']) : null;
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['success_message'] = successMessage;
    return data;
  }
}

class LabProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  int? emailIsVerified;
  String? verificationCode; // Can be null, but here it's a string
  String? labType;
  String? labName;
  String? labAddress;
  String? labProvince;
  List<String>? labPhone; // This will be parsed from a string
  String? labLogo;
  String? labFromHour;
  String? labToHour;
  String? registerDate;
  int? subscriptionIsValidNow;
  int? registerAccepted;

  LabProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.emailIsVerified,
    this.verificationCode,
    this.labType,
    this.labName,
    this.labAddress,
    this.labProvince,
    this.labPhone,
    this.labLogo,
    this.labFromHour,
    this.labToHour,
    this.registerDate,
    this.subscriptionIsValidNow,
    this.registerAccepted,
  });

  LabProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    emailIsVerified = json['email_is_verified'];
    verificationCode = json['verification_code'];
    labType = json['lab_type'];
    labName = json['lab_name'];
    labAddress = json['lab_address'];
    labProvince = json['lab_province'];
    labPhone = decodeLabPhoneNumbers(json['lab_phone']);

    labLogo = json['lab_logo'];
    labFromHour = json['lab_from_hour'];
    labToHour = json['lab_to_hour'];
    registerDate = json['register_date'];
    subscriptionIsValidNow = json['subscription_is_valid_now'];
    registerAccepted = json['register_accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_is_verified'] = emailIsVerified;
    data['verification_code'] = verificationCode;
    data['lab_type'] = labType;
    data['lab_name'] = labName;
    data['lab_address'] = labAddress;
    data['lab_province'] = labProvince;
    data['lab_phone'] = encodeLabPhoneNumbers(labPhone!);

    data['lab_logo'] = labLogo;
    data['lab_from_hour'] = labFromHour;
    data['lab_to_hour'] = labToHour;
    data['register_date'] = registerDate;
    data['subscription_is_valid_now'] = subscriptionIsValidNow;
    data['register_accepted'] = registerAccepted;
    return data;
  }

}
