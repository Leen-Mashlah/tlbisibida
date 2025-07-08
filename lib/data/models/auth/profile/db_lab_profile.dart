import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';
import 'package:lambda_dent_dash/domain/repo/lapphone_chat.dart';

class DBLabProfileResponse {
  bool? status;
  int? successCode;
  DBProfile? profile;
  String? successMessage;

  DBLabProfileResponse({
    this.status,
    this.successCode,
    this.profile,
    this.successMessage,
  });

  DBLabProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    profile =
        json['profile'] != null ? DBProfile.fromJson(json['profile']) : null;
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

  LabProfileResponse toDomain() {
    return LabProfileResponse(
      status: status,
      successCode: successCode,
      profile: profile?.toDomain(),
      successMessage: successMessage,
    );
  }
}

class DBProfile {
  DBLabProfileDetails? LabProfileDetails;
  DBLastSubscription? lastSubscription;

  DBProfile({
    this.LabProfileDetails,
    this.lastSubscription,
  });

  DBProfile.fromJson(Map<String, dynamic> json) {
    LabProfileDetails = json['LabProfileDetails'] != null
        ? DBLabProfileDetails.fromJson(json['LabProfileDetails'])
        : null;
    lastSubscription = json['last_subscription'] != null
        ? DBLastSubscription.fromJson(json['last_subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (LabProfileDetails != null) {
      data['LabProfileDetails'] = LabProfileDetails!.toJson();
    }
    if (lastSubscription != null) {
      data['last_subscription'] = lastSubscription!.toJson();
    }
    return data;
  }

  LabProfile toDomain() {
    return LabProfile(
      profileDetails: LabProfileDetails?.toDomain(),
      lastSubscription: lastSubscription?.toDomain(),
    );
  }
}

class DBLabProfileDetails {
  int? id;
  String? fullName;
  String? email;
  int? registerSubscriptionDuration;
  String? emailVerifiedAt;
  int? emailIsVerified;
  String? verificationCode;
  String? labType;
  String? labName;
  String? labAddress;
  String?
      labPhone; // This is a JSON string, consider parsing to List<String> in toDomain()
  String? labLogo;
  String? workFromHour;
  String? workToHour;
  String? registerDate;
  String? subscriptionIsValidNow;
  String? registerAccepted;
  String? createdAt;
  String? updatedAt;

  DBLabProfileDetails({
    this.id,
    this.fullName,
    this.email,
    this.registerSubscriptionDuration,
    this.emailVerifiedAt,
    this.emailIsVerified,
    this.verificationCode,
    this.labType,
    this.labName,
    this.labAddress,
    this.labPhone,
    this.labLogo,
    this.workFromHour,
    this.workToHour,
    this.registerDate,
    this.subscriptionIsValidNow,
    this.registerAccepted,
    this.createdAt,
    this.updatedAt,
  });

  DBLabProfileDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    registerSubscriptionDuration = json['register_subscription_duration'];
    emailVerifiedAt = json['email_verified_at'];
    emailIsVerified = json['email_is_verified'];
    verificationCode = json['verification_code'];
    labType = json['lab_type'];
    labName = json['lab_name'];
    labAddress = json['lab_address'];
    labPhone = json['lab_phone'];
    labLogo = json['lab_logo'];
    workFromHour = json['work_from_hour'];
    workToHour = json['work_to_hour'];
    registerDate = json['register_date'];
    subscriptionIsValidNow = json['subscription_is_valid_now'];
    registerAccepted = json['register_accepted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['register_subscription_duration'] = registerSubscriptionDuration;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_is_verified'] = emailIsVerified;
    data['verification_code'] = verificationCode;
    data['lab_type'] = labType;
    data['lab_name'] = labName;
    data['lab_address'] = labAddress;
    data['lab_phone'] = labPhone;
    data['lab_logo'] = labLogo;
    data['work_from_hour'] = workFromHour;
    data['work_to_hour'] = workToHour;
    data['register_date'] = registerDate;
    data['subscription_is_valid_now'] = subscriptionIsValidNow;
    data['register_accepted'] = registerAccepted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  LabProfileDetails toDomain() {
    return LabProfileDetails(
      id: id,
      fullName: fullName,
      email: email,
      registerSubscriptionDuration: registerSubscriptionDuration,
      emailVerifiedAt:
          emailVerifiedAt != null ? DateTime.tryParse(emailVerifiedAt!) : null,
      emailIsVerified: emailIsVerified,
      verificationCode: verificationCode,
      labType: labType,
      labName: labName,
      labAddress: labAddress,
      labPhone: decodeLabPhoneNumbers(labPhone!),
      labLogo: labLogo,
      workFromHour: workFromHour,
      workToHour: workToHour,
      registerDate: registerDate,
      subscriptionIsValidNow: subscriptionIsValidNow,
      registerAccepted: registerAccepted,
      createdAt: DateTime.tryParse(createdAt ?? ''),
      updatedAt: DateTime.tryParse(updatedAt ?? ''),
    );
  }
}

class DBLastSubscription {
  int? id;
  String? subscriptionableType;
  int? subscriptionableId;
  String? subscriptionFrom;
  String? subscriptionTo;
  int? subscriptionIsValid;
  int? subscriptionValue;
  String? createdAt;
  String? updatedAt;

  DBLastSubscription({
    this.id,
    this.subscriptionableType,
    this.subscriptionableId,
    this.subscriptionFrom,
    this.subscriptionTo,
    this.subscriptionIsValid,
    this.subscriptionValue,
    this.createdAt,
    this.updatedAt,
  });

  DBLastSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionableType = json['subscriptionable_type'];
    subscriptionableId = json['subscriptionable_id'];
    subscriptionFrom = json['subscription_from'];
    subscriptionTo = json['subscription_to'];
    subscriptionIsValid = json['subscription_is_valid'];
    subscriptionValue = json['subscription_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subscriptionable_type'] = subscriptionableType;
    data['subscriptionable_id'] = subscriptionableId;
    data['subscription_from'] = subscriptionFrom;
    data['subscription_to'] = subscriptionTo;
    data['subscription_is_valid'] = subscriptionIsValid;
    data['subscription_value'] = subscriptionValue;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  LabLastSubscription toDomain() {
    return LabLastSubscription(
      id: id,
      subscriptionableType: subscriptionableType,
      subscriptionableId: subscriptionableId,
      subscriptionFrom: DateTime.tryParse(subscriptionFrom ?? ''),
      subscriptionTo: DateTime.tryParse(subscriptionTo ?? ''),
      subscriptionIsValid: subscriptionIsValid == 1 ? true : false,
      subscriptionValue: subscriptionValue,
      createdAt: DateTime.tryParse(createdAt ?? ''),
      updatedAt: DateTime.tryParse(updatedAt ?? ''),
    );
  }
}
