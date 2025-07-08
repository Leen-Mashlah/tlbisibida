class LabProfileResponse {
  final bool? status;
  final int? successCode;
  final LabProfile? profile;
  final String? successMessage;

  LabProfileResponse({
    this.status,
    this.successCode,
    this.profile,
    this.successMessage,
  });
}

class LabProfile {
  final LabProfileDetails? profileDetails;
  final LabLastSubscription? lastSubscription;

  LabProfile({
    this.profileDetails,
    this.lastSubscription,
  });
}

class LabProfileDetails {
  final int? id;
  final String? fullName;
  final String? email;
  final int? registerSubscriptionDuration;
  final DateTime? emailVerifiedAt;
  final int? emailIsVerified;
  final String? verificationCode;
  final String? labType;
  final String? labName;
  final String? labAddress;
  final List<String>? labPhone;
  final String? labLogo;
  final String? workFromHour;
  final String? workToHour;
  final String? registerDate;
  final String? subscriptionIsValidNow;
  final String? registerAccepted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LabProfileDetails({
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
}

class LabLastSubscription {
  final int? id;
  final String? subscriptionableType;
  final int? subscriptionableId;
  final DateTime? subscriptionFrom;
  final DateTime? subscriptionTo;
  final bool? subscriptionIsValid;
  final int? subscriptionValue;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LabLastSubscription({
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
}
