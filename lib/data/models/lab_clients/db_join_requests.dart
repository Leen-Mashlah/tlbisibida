class DBJoinRequest {
  final int id;
  final String name;
  final int phone;
  final String address;
  final String requestDate;

  DBJoinRequest({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.requestDate,
  });

  factory DBJoinRequest.fromJson(Map<String, dynamic> json) {
    return DBJoinRequest(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      requestDate: json['request_date'],
    );
  }
}

class DBJoinRequestsResponse {
  final bool status;
  final int successCode;
  final List<DBJoinRequest> joinRequests;
  final String successMessage;

  DBJoinRequestsResponse({
    required this.status,
    required this.successCode,
    required this.joinRequests,
    required this.successMessage,
  });

  factory DBJoinRequestsResponse.fromJson(Map<String, dynamic> json) {
    return DBJoinRequestsResponse(
      status: json['status'],
      successCode: json['success_code'],
      joinRequests: (json['join requests'] as List)
          .map((e) => DBJoinRequest.fromJson(e))
          .toList(),
      successMessage: json['success_message'],
    );
  }
}
