import 'package:lambda_dent_dash/domain/models/statistics/item_monthly_point.dart';

class DBItemMonthlyPoint {
  final int month;
  final double negativeQuantity;

  DBItemMonthlyPoint({required this.month, required this.negativeQuantity});

  factory DBItemMonthlyPoint.fromJson(Map<String, dynamic> json) =>
      DBItemMonthlyPoint(
        month: json['month'] ?? 0,
        negativeQuantity: _toDouble(json['Negative quantity']),
      );

  ItemMonthlyPoint toDomain() =>
      ItemMonthlyPoint(month: month, negativeQuantity: negativeQuantity);
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}
