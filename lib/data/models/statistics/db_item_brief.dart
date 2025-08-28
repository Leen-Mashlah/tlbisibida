import 'package:lambda_dent_dash/domain/models/statistics/item_brief.dart';

class DBItemBrief {
  final int id;
  final String name;

  DBItemBrief({required this.id, required this.name});

  factory DBItemBrief.fromJson(Map<String, dynamic> json) =>
      DBItemBrief(id: json['id'] ?? 0, name: json['name']?.toString() ?? '');

  ItemBrief toDomain() => ItemBrief(id: id, name: name);
}
