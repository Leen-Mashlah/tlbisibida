class Client {
  final int id;
  final String name;
  final int phone;
  final String address;
  final String joinedOn;
  final int currentAccount;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.joinedOn,
    required this.currentAccount,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      joinedOn: json['joined_on'],
      currentAccount: json['current_account'],
    );
  }
}

class ClientsResponse {
  final bool status;
  final int successCode;
  final List<Client> clients;
  final String successMessage;

  ClientsResponse({
    required this.status,
    required this.successCode,
    required this.clients,
    required this.successMessage,
  });

  factory ClientsResponse.fromJson(Map<String, dynamic> json) {
    return ClientsResponse(
      status: json['status'],
      successCode: json['success_code'],
      clients:
          (json['clients'] as List).map((e) => Client.fromJson(e)).toList(),
      successMessage: json['success_message'],
    );
  }
}

class JoinRequest {
  final int id;
  final String name;
  final int phone;
  final String address;
  final String requestDate;

  JoinRequest({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.requestDate,
  });
}

class JoinRequestsResponse {
  final bool status;
  final int successCode;
  final List<JoinRequest> joinRequests;
  final String successMessage;

  JoinRequestsResponse({
    required this.status,
    required this.successCode,
    required this.joinRequests,
    required this.successMessage,
  });
}
