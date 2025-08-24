import '../../../domain/models/inventory/show_cats.dart';

class DBCategoriesResponse {
  bool? status;
  int? successCode;
  List<DBCategory>? categories;
  String? successMessage;

  DBCategoriesResponse(
      {this.status, this.successCode, this.categories, this.successMessage});

  DBCategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    if (json['categories'] != null) {
      categories = <DBCategory>[];
      json['categories'].forEach((v) {
        categories!.add(DBCategory.fromJson(v));
      });
    }
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['success_message'] = successMessage;
    return data;
  }
}

class DBCategory {
  int? id;
  String? name;

  DBCategory({this.id, this.name});

  DBCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  } // --- TO DOMAIN FUNCTION ---

  Category toDomain() {
    return Category(
      id: id,
      name: name,
    );
  }

  // --- FROM DOMAIN FUNCTION ---
  static DBCategory fromDomain(Category domain) {
    return DBCategory(
      id: domain.id,
      name: domain.name,
    );
  }
}
