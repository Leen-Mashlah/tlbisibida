import '../../../domain/models/inventory/repeated_items.dart';

class DBRepeatedItem {
  String? name;
  int? quantity;
  int? totalPrice;
  String? createdAt;

  DBRepeatedItem({
    this.name,
    this.quantity,
    this.totalPrice,
    this.createdAt,
  });

  factory DBRepeatedItem.fromJson(Map<String, dynamic> json) {
    return DBRepeatedItem(
      name: json['name'] as String?,
      quantity: json['quantity'] as int?,
      totalPrice: json['total_price'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    return data;
  }

  // Convert to domain model
  RepeatedItem toDomain() {
    return RepeatedItem(
      name: name,
      quantity: quantity,
      totalPrice: totalPrice,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }

  // Convert from domain model
  static DBRepeatedItem fromDomain(RepeatedItem domain) {
    return DBRepeatedItem(
      name: domain.name,
      quantity: domain.quantity,
      totalPrice: domain.totalPrice,
      createdAt: domain.createdAt?.toIso8601String(),
    );
  }
}

class DBRepeatedItemsResponse {
  bool? status;
  int? successCode;
  List<DBRepeatedItem>? repeatedItems;
  String? successMessage;

  DBRepeatedItemsResponse({
    this.status,
    this.successCode,
    this.repeatedItems,
    this.successMessage,
  });

  factory DBRepeatedItemsResponse.fromJson(Map<String, dynamic> json) {
    return DBRepeatedItemsResponse(
      status: json['status'] as bool?,
      successCode: json['success_code'] as int?,
      repeatedItems: (json['Rpeated_items'] as List<dynamic>?)
          ?.map((e) => DBRepeatedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      successMessage: json['success_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (repeatedItems != null) {
      data['Rpeated_items'] = repeatedItems!.map((e) => e.toJson()).toList();
    }
    data['success_message'] = successMessage;
    return data;
  }

  // Convert to domain model
  RepeatedItemsResponse toDomain() {
    return RepeatedItemsResponse(
      status: status,
      successCode: successCode,
      repeatedItems: repeatedItems?.map((e) => e.toDomain()).toList(),
      successMessage: successMessage,
    );
  }

  // Convert from domain model
  static DBRepeatedItemsResponse fromDomain(RepeatedItemsResponse domain) {
    return DBRepeatedItemsResponse(
      status: domain.status,
      successCode: domain.successCode,
      repeatedItems: domain.repeatedItems?.map((e) => DBRepeatedItem.fromDomain(e)).toList(),
      successMessage: domain.successMessage,
    );
  }
}
