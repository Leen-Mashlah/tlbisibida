import '../../../domain/models/inventory/non_repeated_items.dart';

class DBNonRepeatedItem {
  String? name;
  int? quantity;
  int? totalPrice;
  String? createdAt;

  DBNonRepeatedItem({
    this.name,
    this.quantity,
    this.totalPrice,
    this.createdAt,
  });

  factory DBNonRepeatedItem.fromJson(Map<String, dynamic> json) {
    return DBNonRepeatedItem(
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
  NonRepeatedItem toDomain() {
    return NonRepeatedItem(
      name: name,
      quantity: quantity,
      totalPrice: totalPrice,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }

  // Convert from domain model
  static DBNonRepeatedItem fromDomain(NonRepeatedItem domain) {
    return DBNonRepeatedItem(
      name: domain.name,
      quantity: domain.quantity,
      totalPrice: domain.totalPrice,
      createdAt: domain.createdAt?.toIso8601String(),
    );
  }
}

class DBNonRepeatedItemsResponse {
  bool? status;
  int? successCode;
  List<DBNonRepeatedItem>? nonRepeatedItems;
  String? successMessage;

  DBNonRepeatedItemsResponse({
    this.status,
    this.successCode,
    this.nonRepeatedItems,
    this.successMessage,
  });

  factory DBNonRepeatedItemsResponse.fromJson(Map<String, dynamic> json) {
    return DBNonRepeatedItemsResponse(
      status: json['status'] as bool?,
      successCode: json['success_code'] as int?,
      nonRepeatedItems: (json['Non_Rpeated_items'] as List<dynamic>?)
          ?.map((e) => DBNonRepeatedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      successMessage: json['success_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (nonRepeatedItems != null) {
      data['Non_Rpeated_items'] = nonRepeatedItems!.map((e) => e.toJson()).toList();
    }
    data['success_message'] = successMessage;
    return data;
  }

  // Convert to domain model
  NonRepeatedItemsResponse toDomain() {
    return NonRepeatedItemsResponse(
      status: status,
      successCode: successCode,
      nonRepeatedItems: nonRepeatedItems?.map((e) => e.toDomain()).toList(),
      successMessage: successMessage,
    );
  }

  // Convert from domain model
  static DBNonRepeatedItemsResponse fromDomain(NonRepeatedItemsResponse domain) {
    return DBNonRepeatedItemsResponse(
      status: domain.status,
      successCode: domain.successCode,
      nonRepeatedItems: domain.nonRepeatedItems?.map((e) => DBNonRepeatedItem.fromDomain(e)).toList(),
      successMessage: domain.successMessage,
    );
  }
}
