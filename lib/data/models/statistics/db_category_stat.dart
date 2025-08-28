import 'package:lambda_dent_dash/domain/models/statistics/category_stat.dart';

class DBCategoryStat {
  final int categoryId;
  final String categoryName;
  final double totalPriceLastMonth;
  final double totalQuantityLastMonth;
  final double percentage;

  DBCategoryStat({
    required this.categoryId,
    required this.categoryName,
    required this.totalPriceLastMonth,
    required this.totalQuantityLastMonth,
    required this.percentage,
  });

  factory DBCategoryStat.fromJson(Map<String, dynamic> json) => DBCategoryStat(
        categoryId: json['category_id'] ?? 0,
        categoryName: json['category_name']?.toString() ?? '',
        totalPriceLastMonth: _toDouble(json['total_price_last_month']),
        totalQuantityLastMonth: _toDouble(json['total_quantity_last_month']),
        percentage: _toDouble(json['percentage']),
      );

  CategoryStat toDomain() => CategoryStat(
        categoryId: categoryId,
        categoryName: categoryName,
        totalPriceLastMonth: totalPriceLastMonth,
        totalQuantityLastMonth: totalQuantityLastMonth,
        percentage: percentage,
      );
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}
