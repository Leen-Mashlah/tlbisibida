class RepeatedItem {
  final String? name;
  final int? quantity;
  final int? totalPrice;
  final DateTime? createdAt;

  RepeatedItem({
    this.name,
    this.quantity,
    this.totalPrice,
    this.createdAt,
  });

  factory RepeatedItem.fromJson(Map<String, dynamic> json) {
    return RepeatedItem(
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
  }
}

class RepeatedItemsResponse {
  final bool? status;
  final int? successCode;
  final List<RepeatedItem>? repeatedItems;
  final String? successMessage;

  RepeatedItemsResponse({
    this.status,
    this.successCode,
    this.repeatedItems,
    this.successMessage,
  });

  factory RepeatedItemsResponse.fromJson(Map<String, dynamic> json) {
    return RepeatedItemsResponse(
      status: json['status'] as bool?,
      successCode: json['success_code'] as int?,
      repeatedItems: (json['Rpeated_items'] as List<dynamic>?)
          ?.map((e) => RepeatedItem.fromJson(e as Map<String, dynamic>))
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
}
