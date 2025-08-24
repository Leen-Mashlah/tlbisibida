import '../../../domain/models/inventory/show_quants_for_items.dart';

class DBItemQuantityHistoryResponse {
  bool? status;
  int? successCode;
  List<DBItemQuantityHistory>? items;
  String? successMessage;

  DBItemQuantityHistoryResponse({
    this.status,
    this.successCode,
    this.items,
    this.successMessage,
  });

  factory DBItemQuantityHistoryResponse.fromJson(Map<String, dynamic> json) {
    return DBItemQuantityHistoryResponse(
      status: json['status'] as bool?,
      successCode: json['success_code'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => DBItemQuantityHistory.fromJson(e as Map<String, dynamic>))
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

class DBItemQuantityHistory {
  int? id;
  DateTime? createdAt; // Changed to DateTime
  int? quantity;
  int? newValue;
  int? recentValue;

  DBItemQuantityHistory({
    this.id,
    this.createdAt,
    this.quantity,
    this.newValue,
    this.recentValue,
  });

  factory DBItemQuantityHistory.fromJson(Map<String, dynamic> json) {
    return DBItemQuantityHistory(
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

  // --- TO DOMAIN FUNCTION ---
  // Since DBItemQuantityHistory and ItemQuantityHistory are identical, the mapping is direct.
  ItemQuantityHistory toDomain() {
    return ItemQuantityHistory(
      id: id,
      createdAt: createdAt, // Direct mapping of DateTime
      quantity: quantity,
      newValue: newValue,
      recentValue: recentValue,
    );
  }

  // --- FROM DOMAIN FUNCTION ---
  // Since DBItemQuantityHistory and ItemQuantityHistory are identical, the mapping is direct.
  static DBItemQuantityHistory fromDomain(ItemQuantityHistory domain) {
    return DBItemQuantityHistory(
      id: domain.id,
      createdAt: domain.createdAt, // Direct mapping of DateTime
      quantity: domain.quantity,
      newValue: domain.newValue,
      recentValue: domain.recentValue,
    );
  }
}
