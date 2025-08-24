import '../../../domain/models/inventory/show_items_log.dart';

class DBRepeatedItemsResponse {
  bool? status;
  int? successCode;
  List<DBRepeatedItem>? repeatedItems; // Corrected from Rpeated_items
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
      // Note: We use the original JSON key 'Rpeated_items' for parsing
      // but map it to the Dart field 'repeatedItems'.
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
    // When converting back to JSON, use the original JSON key 'Rpeated_items'
    if (repeatedItems != null) {
      data['Rpeated_items'] = repeatedItems!.map((v) => v.toJson()).toList();
    }
    data['success_message'] = successMessage;
    return data;
  }
}

class DBRepeatedItem {
  String? name;
  int? quantity;
  int?
      totalPrice; // Changed to int based on sample, use double if decimals possible
  DateTime? createdAt; // Changed to DateTime

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
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  } // --- TO DOMAIN FUNCTION ---

  // Since DBRepeatedItem and RepeatedItem are identical, the mapping is direct.
  RepeatedItem toDomain() {
    return RepeatedItem(
      name: name,
      quantity: quantity,
      totalPrice: totalPrice,
      createdAt: createdAt, // Direct mapping of DateTime
    );
  }

  // --- FROM DOMAIN FUNCTION ---
  // Since DBRepeatedItem and RepeatedItem are identical, the mapping is direct.
  static DBRepeatedItem fromDomain(RepeatedItem domain) {
    return DBRepeatedItem(
      name: domain.name,
      quantity: domain.quantity,
      totalPrice: domain.totalPrice,
      createdAt: domain.createdAt, // Direct mapping of DateTime
    );
  }
}
