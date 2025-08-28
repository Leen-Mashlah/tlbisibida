class CategoryStat {
  final int categoryId;
  final String categoryName;
  final double totalPriceLastMonth;
  final double totalQuantityLastMonth;
  final double percentage;

  CategoryStat({
    required this.categoryId,
    required this.categoryName,
    required this.totalPriceLastMonth,
    required this.totalQuantityLastMonth,
    required this.percentage,
  });
}
