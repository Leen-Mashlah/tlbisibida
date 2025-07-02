class DentistProfileResponse {
  bool? status;
  int? successCode;
  DentistProfile? profile;
  String? successMessage;

  DentistProfileResponse(
      {this.status, this.successCode, this.profile, this.successMessage});

  DentistProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    profile = json['profile'] != null
        ? DentistProfile.fromJson(json['profile'])
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

class DentistProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? phone; // Assuming phone can be an int based on the example
  String? address;
  String? province;
  String? emailVerifiedAt;
  int? emailIsVerified;
  String? verificationCode;
  String? imagePath;
  int? registerAccepted;
  String? registerDate;
  int? subscriptionIsValidNow;

  DentistProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.province,
    this.emailVerifiedAt,
    this.emailIsVerified,
    this.verificationCode,
    this.imagePath,
    this.registerAccepted,
    this.registerDate,
    this.subscriptionIsValidNow,
  });

  DentistProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    province = json['province'];
    emailVerifiedAt = json['email_verified_at'];
    emailIsVerified = json['email_is_verified'];
    verificationCode = json['verification_code'];
    imagePath = json['image_path'];
    registerAccepted = json['register_accepted'];
    registerDate = json['register_date'];
    subscriptionIsValidNow = json['subscription_is_valid_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['province'] = province;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_is_verified'] = emailIsVerified;
    data['verification_code'] = verificationCode;
    data['image_path'] = imagePath;
    data['register_accepted'] = registerAccepted;
    data['register_date'] = registerDate;
    data['subscription_is_valid_now'] = subscriptionIsValidNow;
    return data;
  }
}
