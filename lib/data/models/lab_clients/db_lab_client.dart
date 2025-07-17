class DBLabClient {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int registerSubscriptionDuration;
  final int phone;
  final String address;
  final String? emailVerifiedAt;
  final int emailIsVerified;
  final String verificationCode;
  final String imagePath;
  final bool? registerAccepted;
  final String registerDate;
  final bool? subscriptionIsValidNow;
  final String createdAt;
  final String updatedAt;

  DBLabClient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.registerSubscriptionDuration,
    required this.phone,
    required this.address,
    required this.emailVerifiedAt,
    required this.emailIsVerified,
    required this.verificationCode,
    required this.imagePath,
    required this.registerAccepted,
    required this.registerDate,
    required this.subscriptionIsValidNow,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DBLabClient.fromJson(Map<String, dynamic> json) {
    return DBLabClient(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      registerSubscriptionDuration: json['register_subscription_duration'],
      phone: json['phone'],
      address: json['address'],
      emailVerifiedAt: json['email_verified_at'],
      emailIsVerified: json['email_is_verified'],
      verificationCode: json['verification_code'],
      imagePath: json['image_path'],
      registerAccepted: json['register_accepted'],
      registerDate: json['register_date'],
      subscriptionIsValidNow: json['subscription_is_valid_now'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'register_subscription_duration': registerSubscriptionDuration,
        'phone': phone,
        'address': address,
        'email_verified_at': emailVerifiedAt,
        'email_is_verified': emailIsVerified,
        'verification_code': verificationCode,
        'image_path': imagePath,
        'register_accepted': registerAccepted,
        'register_date': registerDate,
        'subscription_is_valid_now': subscriptionIsValidNow,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class DBLabClientsResponse {
  final bool status;
  final int successCode;
  final List<DBLabClient> labClients;
  final String successMessage;

  DBLabClientsResponse({
    required this.status,
    required this.successCode,
    required this.labClients,
    required this.successMessage,
  });

  factory DBLabClientsResponse.fromJson(Map<String, dynamic> json) {
    return DBLabClientsResponse(
      status: json['status'],
      successCode: json['success_code'],
      labClients: (json['lab_clients'] as List)
          .map((e) => DBLabClient.fromJson(e))
          .toList(),
      successMessage: json['success_message'],
    );
  }
}
