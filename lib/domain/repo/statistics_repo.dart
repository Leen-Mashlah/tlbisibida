import 'package:lambda_dent_dash/domain/models/statistics/category_stat.dart';
import 'package:lambda_dent_dash/domain/models/statistics/op_payment_stat.dart';
import 'package:lambda_dent_dash/domain/models/statistics/doctor_profit.dart';
import 'package:lambda_dent_dash/domain/models/statistics/item_brief.dart';
import 'package:lambda_dent_dash/domain/models/statistics/item_monthly_point.dart';

abstract class StatisticsRepo {
  Future<List<CategoryStat>> getCategoriesStatistics();
  Future<List<OperatingPaymentStat>> getOperatingPaymentsStatistics();
  Future<List<DoctorProfit>> getMostProfitableDoctors();
  Future<List<ItemBrief>> getItemsOfUser();
  Future<List<ItemMonthlyPoint>> getMonthlyConsumptionOfItem(int itemId);
}
