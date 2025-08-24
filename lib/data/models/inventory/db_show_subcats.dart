import '../../../domain/models/inventory/show_subcats.dart';

class DBSubCategoryRepositoriesResponse {
  bool? status;
  int? successCode;
  List<DBSubCategoryRepository>? subCategoryRepositories;
  String? successMessage;

  DBSubCategoryRepositoriesResponse(
      {this.status,
      this.successCode,
      this.subCategoryRepositories,
      this.successMessage});

  DBSubCategoryRepositoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    if (json['subCategoryRepositories'] != null) {
      subCategoryRepositories = <DBSubCategoryRepository>[];
      json['subCategoryRepositories'].forEach((v) {
        subCategoryRepositories!.add(DBSubCategoryRepository.fromJson(v));
      });
    }
    successMessage = json['success_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success_code'] = successCode;
    if (subCategoryRepositories != null) {
      data['subCategoryRepositories'] =
          subCategoryRepositories!.map((v) => v.toJson()).toList();
    }
    data['success_message'] = successMessage;
    return data;
  }
}

class DBSubCategoryRepository {
  int? id;
  String? name;

  DBSubCategoryRepository({this.id, this.name});

  DBSubCategoryRepository.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  } // --- TO DOMAIN FUNCTION ---

  // Since DBSubCategoryRepository and SubCategoryRepository are identical, the mapping is direct.
  SubCategoryRepository toDomain() {
    return SubCategoryRepository(
      id: id,
      name: name,
    );
  }

  // --- FROM DOMAIN FUNCTION ---
  // Since DBSubCategoryRepository and SubCategoryRepository are identical, the mapping is direct.
  static DBSubCategoryRepository fromDomain(SubCategoryRepository domain) {
    return DBSubCategoryRepository(
      id: domain.id,
      name: domain.name,
    );
  }
}
