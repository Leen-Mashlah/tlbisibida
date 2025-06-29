class DBItemsResponse {
  bool? status;
  int? successCode;
  List<Item>? items;
  String? successMessage;

  DBItemsResponse(
      {this.status, this.successCode, this.items, this.successMessage});

  DBItemsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
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

class Item {
  String? name;
  int? quantity;
  int? standardQuantity;
  int? minimumQuantity;
  String? unit;
  int? isStatic;

  Item({
    this.name,
    this.quantity,
    this.standardQuantity,
    this.minimumQuantity,
    this.unit,
    this.isStatic,
  });

  Item.fromJson(Map<String, dynamic> json) {
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
}
