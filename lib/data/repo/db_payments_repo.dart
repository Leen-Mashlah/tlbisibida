import 'package:lambda_dent_dash/data/models/payments/db_lab_item_history.dart';
import 'package:lambda_dent_dash/domain/models/payments/lab_item_history.dart';
import 'package:lambda_dent_dash/domain/repo/payments_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBPaymentsRepo implements PaymentsRepo {
  @override
  Future<List<LabItemHistory>> getLabItemsHistory() async {
    try {
      final res = await DioHelper.getData('inventory/lab-items-history',
          token: CacheHelper.get('token'));
      final list = (res?.data?['lab_items_history'] as List?) ?? [];
      return list.map((e) => DBLabItemHistory.fromJson(e).toDomain()).toList();
    } catch (_) {
      return [];
    }
  }
}
