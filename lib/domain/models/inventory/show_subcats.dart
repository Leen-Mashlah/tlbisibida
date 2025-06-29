class SubCategoryRepositoriesResponse {
  bool? status;
  int? successCode;
  List<SubCategoryRepository>? subCategoryRepositories;
  String? successMessage;

  SubCategoryRepositoriesResponse(
      {this.status,
      this.successCode,
      this.subCategoryRepositories,
      this.successMessage});

  SubCategoryRepositoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successCode = json['success_code'];
    if (json['subCategoryRepositories'] != null) {
      subCategoryRepositories = <SubCategoryRepository>[];
      json['subCategoryRepositories'].forEach((v) {
        subCategoryRepositories!.add(SubCategoryRepository.fromJson(v));
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

class SubCategoryRepository {
  int? id;
  String? name;

  SubCategoryRepository({this.id, this.name});

  SubCategoryRepository.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
