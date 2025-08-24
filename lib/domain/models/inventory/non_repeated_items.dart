class NonRepeatedItem {
  final String? name;
  final int? quantity;
  final int? totalPrice;
  final DateTime? createdAt;

  NonRepeatedItem({
    this.name,
    this.quantity,
    this.totalPrice,
    this.createdAt,
  });

  factory NonRepeatedItem.fromJson(Map<String, dynamic> json) {
    return NonRepeatedItem(
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

class NonRepeatedItemsResponse {
  final bool? status;
  final int? successCode;
  final List<NonRepeatedItem>? nonRepeatedItems;
  final String? successMessage;

  NonRepeatedItemsResponse({
    this.status,
    this.successCode,
    this.nonRepeatedItems,
    this.successMessage,
  });

  factory NonRepeatedItemsResponse.fromJson(Map<String, dynamic> json) {
    return NonRepeatedItemsResponse(
      status: json['status'] as bool?,
      successCode: json['success_code'] as int?,
      nonRepeatedItems: (json['Non_Rpeated_items'] as List<dynamic>?)
          ?.map((e) => NonRepeatedItem.fromJson(e as Map<String, dynamic>))
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
}
