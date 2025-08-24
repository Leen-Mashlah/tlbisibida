import '../../../domain/models/inventory/show_items.dart';

class DBItemsResponse {
  bool? status;
  int? successCode;
  List<DBItem>? items;
  String? successMessage;

  DBItemsResponse(
      {this.status, this.successCode, this.items, this.successMessage});

  DBItemsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    if (json['items'] != null) {
      items = <DBItem>[];
      json['items'].forEach((v) {
        items!.add(DBItem.fromJson(v));
      });
    }
    successMessage = json['success_message'];
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

class DBItem {
  String? name;
  int? quantity;
  int? standardQuantity;
  int? minimumQuantity;
  String? unit;
  int? isStatic;

  DBItem({
    this.name,
    this.quantity,
    this.standardQuantity,
    this.minimumQuantity,
    this.unit,
    this.isStatic,
  });

  DBItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    standardQuantity = json['standard_quantity'];
    minimumQuantity = json['minimum_quantity'];
    unit = json['unit'];
    isStatic = json['is_static'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['standard_quantity'] = standardQuantity;
    data['minimum_quantity'] = minimumQuantity;
    data['unit'] = unit;
    data['is_static'] = isStatic;
    return data;
  }

  // --- TO DOMAIN FUNCTION ---
  Item toDomain() {
    return Item(
      name: name,
      quantity: quantity,
      standardQuantity: standardQuantity,
      minimumQuantity: minimumQuantity,
      unit: unit,
      isStatic: isStatic == 1, // Convert int (0 or 1) to bool
    );
  }

  // --- FROM DOMAIN FUNCTION ---
  static DBItem fromDomain(Item domain) {
    return DBItem(
      name: domain.name,
      quantity: domain.quantity,
      standardQuantity: domain.standardQuantity,
      minimumQuantity: domain.minimumQuantity,
      unit: domain.unit,
      isStatic: domain.isStatic == true ? 1 : 0, // Convert bool to int (1 or 0)
    );
  }
}
