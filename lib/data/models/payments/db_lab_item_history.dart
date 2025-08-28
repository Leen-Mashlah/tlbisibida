import 'package:lambda_dent_dash/domain/models/payments/lab_item_history.dart';

class DBLabItemHistory {
  final int id;
  final int itemId;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String createdAt;
  final int itemInnerId;
  final String itemName;

  DBLabItemHistory({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.itemInnerId,
    required this.itemName,
  });

  factory DBLabItemHistory.fromJson(Map<String, dynamic> json) =>
      DBLabItemHistory(
        id: json['id'] ?? 0,
        itemId: json['item_id'] ?? 0,
        quantity: _toDouble(json['quantity']),
        unitPrice: _toDouble(json['unit_price']),
        totalPrice: _toDouble(json['total_price']),
        createdAt: json['created_at']?.toString() ?? '',
        itemInnerId: json['item']?['id'] ?? 0,
        itemName: json['item']?['name']?.toString() ?? '',
      );

  LabItemHistory toDomain() => LabItemHistory(
        id: id,
        itemId: itemId,
        quantity: quantity,
        unitPrice: unitPrice,
        totalPrice: totalPrice,
        createdAt: createdAt,
        itemInnerId: itemInnerId,
        itemName: itemName,
      );
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}
