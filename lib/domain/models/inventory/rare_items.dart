// Ensure this model is in the same file or imported where RepeatedItem is defined
// If RepeatedItem is in a separate file (e.g., 'repeated_items_model.dart'),
// you would import it like:
// import 'package:your_app/models/repeated_items_model.dart';

import 'package:lambda_dent_dash/data/models/inventory/db_show_items_log.dart';

class NonRepeatedItemsResponse {
  bool? status;
  int? successCode;
  List<RepeatedItem>? nonRepeatedItems; // Reusing RepeatedItem model
  String? successMessage;

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
      // Note: We use the original JSON key 'Non_Rpeated_items' for parsing
      // but map it to the Dart field 'nonRepeatedItems'.
      nonRepeatedItems: (json['Non_Rpeated_items'] as List<dynamic>?)
          ?.map((e) => RepeatedItem.fromJson(
              e as Map<String, dynamic>)) // Reusing RepeatedItem
          .toList(),
      successMessage: json['success_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    // When converting back to JSON, use the original JSON key 'Non_Rpeated_items'
    if (nonRepeatedItems != null) {
      data['Non_Rpeated_items'] =
          nonRepeatedItems!.map((v) => v.toJson()).toList();
    }
    data['success_message'] = successMessage;
    return data;
  }
}

// The RepeatedItem class definition (if not already in a common_models.dart or similar)
// If it's already defined elsewhere and imported, you don't need to repeat this.
/*
class RepeatedItem {
  String? name;
  int? quantity;
  int? totalPrice;
  DateTime? createdAt;

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
*/