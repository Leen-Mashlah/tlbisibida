import 'package:lambda_dent_dash/domain/models/statistics/op_payment_stat.dart';

class DBOperatingPaymentStat {
  final String name;
  final double totalValue;
  final double count;
  final double percentage;

  DBOperatingPaymentStat({
    required this.name,
    required this.totalValue,
    required this.count,
    required this.percentage,
  });

  factory DBOperatingPaymentStat.fromJson(Map<String, dynamic> json) =>
      DBOperatingPaymentStat(
        name: json['name']?.toString() ?? '',
        totalValue: _toDouble(json['total_value']),
        count: _toDouble(json['count']),
        percentage: _toDouble(json['percentage']),
      );

  OperatingPaymentStat toDomain() => OperatingPaymentStat(
        name: name,
        totalValue: totalValue,
        count: count,
        percentage: percentage,
      );
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}
