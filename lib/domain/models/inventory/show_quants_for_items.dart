class ItemQuantityHistoryResponse {
  bool? status;
  int? successCode;
  List<ItemQuantityHistory>? items;
  String? successMessage;

  ItemQuantityHistoryResponse({
    this.status,
    this.successCode,
    this.items,
    this.successMessage,
  });

  factory ItemQuantityHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ItemQuantityHistoryResponse(
      status: json['status'] as bool?,
      successCode: json['success_code'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemQuantityHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      successMessage: json['success_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['success_message'] = successMessage;
    return data;
  }
}

class ItemQuantityHistory {
  int? id;
  DateTime? createdAt; // Changed to DateTime
  int? quantity;
  int? newValue;
  int? recentValue;

  ItemQuantityHistory({
    this.id,
    this.createdAt,
    this.quantity,
    this.newValue,
    this.recentValue,
  });

  factory ItemQuantityHistory.fromJson(Map<String, dynamic> json) {
    return ItemQuantityHistory(
      id: json['id'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) // Parse to DateTime
          : null,
      quantity: json['quantity'] as int?,
      newValue: json['new_value'] as int?,
      recentValue: json['recent_value'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt?.toIso8601String(); // Convert back to string
    data['quantity'] = quantity;
    data['new_value'] = newValue;
    data['recent_value'] = recentValue;
    return data;
  }
}
