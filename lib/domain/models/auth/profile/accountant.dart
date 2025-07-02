class AccountantProfileResponse {
  bool? status;
  int? successCode;
  LabManagerProfile? profile;
  String? successMessage;

  AccountantProfileResponse(
      {this.status, this.successCode, this.profile, this.successMessage});

  AccountantProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    profile = json['profile'] != null
        ? LabManagerProfile.fromJson(json['profile'])
        : null;
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

class LabManagerProfile {
  int? id;
  int? labManagerId;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  int? emailIsVerified;
  dynamic verificationCode;
  int? isStaged;
  String? phone;

  LabManagerProfile({
    this.id,
    this.labManagerId,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.emailIsVerified,
    this.verificationCode,
    this.isStaged,
    this.phone,
  });

  LabManagerProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    labManagerId = json['lab_manager_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    emailIsVerified = json['email_is_verified'];
    verificationCode = json['verification_code'];
    isStaged = json['is_staged'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lab_manager_id'] = labManagerId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_is_verified'] = emailIsVerified;
    data['verification_code'] = verificationCode;
    data['is_staged'] = isStaged;
    data['phone'] = phone;
    return data;
  }
}
