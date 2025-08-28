import 'package:lambda_dent_dash/data/models/statistics/db_category_stat.dart';
import 'package:lambda_dent_dash/data/models/statistics/db_op_payment_stat.dart';
import 'package:lambda_dent_dash/data/models/statistics/db_doctor_profit.dart';
import 'package:lambda_dent_dash/data/models/statistics/db_item_brief.dart';
import 'package:lambda_dent_dash/data/models/statistics/db_item_monthly_point.dart';
import 'package:lambda_dent_dash/domain/models/statistics/category_stat.dart';
import 'package:lambda_dent_dash/domain/models/statistics/op_payment_stat.dart';
import 'package:lambda_dent_dash/domain/models/statistics/doctor_profit.dart';
import 'package:lambda_dent_dash/domain/models/statistics/item_brief.dart';
import 'package:lambda_dent_dash/domain/models/statistics/item_monthly_point.dart';
import 'package:lambda_dent_dash/domain/repo/statistics_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBStatisticsRepo implements StatisticsRepo {
  @override
  Future<List<CategoryStat>> getCategoriesStatistics() async {
    try {
      final response = await DioHelper.getData(
          'lab-manager/statistics/categories_statistics',
          token: CacheHelper.get('token'));
      final list = (response?.data?["statistics of categories"] as List?) ?? [];
      return list.map((e) => DBCategoryStat.fromJson(e).toDomain()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<OperatingPaymentStat>> getOperatingPaymentsStatistics() async {
    try {
      final response = await DioHelper.getData(
          'lab-manager/statistics/LabManager_Operating_Payment_statistics',
          token: CacheHelper.get('token'));
      final list = (response?.data?["Operating_Payments"] as List?) ?? [];
      return list
          .map((e) => DBOperatingPaymentStat.fromJson(e).toDomain())
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<DoctorProfit>> getMostProfitableDoctors() async {
    try {
      final response = await DioHelper.getData(
          'lab-manager/statistics/Most_profitable_doctors',
          token: CacheHelper.get('token'));
      final list = (response?.data?["Most_profitable_doctors"] as List?) ?? [];
      return list.map((e) => DBDoctorProfit.fromJson(e).toDomain()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ItemBrief>> getItemsOfUser() async {
    try {
      final response = await DioHelper.getData(
          'lab-manager/statistics/items_of_user',
          token: CacheHelper.get('token'));
      final list = (response?.data?["items"] as List?) ?? [];
      return list.map((e) => DBItemBrief.fromJson(e).toDomain()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ItemMonthlyPoint>> getMonthlyConsumptionOfItem(int itemId) async {
    try {
      final response = await DioHelper.getData(
          'lab-manager/statistics/The_monthly_consumption_of_item/$itemId',
          token: CacheHelper.get('token'));
      final list = (response?.data?["statistic of monthly consumption of item"]
              as List?) ??
          [];
      return list
          .map((e) => DBItemMonthlyPoint.fromJson(e).toDomain())
          .toList();
    } catch (e) {
      return [];
    }
  }
}
