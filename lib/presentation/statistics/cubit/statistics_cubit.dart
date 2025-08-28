import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/statistics/category_stat.dart';
import 'package:lambda_dent_dash/domain/models/statistics/doctor_profit.dart';
import 'package:lambda_dent_dash/domain/models/statistics/item_brief.dart';
import 'package:lambda_dent_dash/domain/models/statistics/item_monthly_point.dart';
import 'package:lambda_dent_dash/domain/models/statistics/op_payment_stat.dart';
import 'package:lambda_dent_dash/domain/repo/statistics_repo.dart';
import 'package:lambda_dent_dash/presentation/statistics/cubit/statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit(this.repo) : super(StatisticsInitial());

  final StatisticsRepo repo;

  List<CategoryStat> categories = [];
  List<OperatingPaymentStat> operatingPayments = [];
  List<DoctorProfit> doctorProfits = [];
  List<ItemBrief> items = [];
  List<ItemMonthlyPoint> itemMonthly = [];

  Future<void> loadAll() async {
    if (isClosed) return;
    emit(StatisticsLoading());
    try {
      final cats = await repo.getCategoriesStatistics();
      final ops = await repo.getOperatingPaymentsStatistics();
      final docs = await repo.getMostProfitableDoctors();
      final itemsList = await repo.getItemsOfUser();

      categories = cats;
      operatingPayments = ops;
      doctorProfits = docs;
      items = itemsList;

      // Optionally load first item series if available
      if (items.isNotEmpty) {
        itemMonthly = await repo.getMonthlyConsumptionOfItem(items.first.id);
      } else {
        itemMonthly = [];
      }

      if (isClosed) return;
      emit(_buildLoadedState());
    } catch (e) {
      if (isClosed) return;
      emit(StatisticsError(e.toString()));
    }
  }

  Future<void> loadItemMonthly(int itemId) async {
    try {
      itemMonthly = await repo.getMonthlyConsumptionOfItem(itemId);
      if (isClosed) return;
      final current = _buildLoadedState();
      emit(current);
    } catch (e) {
      if (isClosed) return;
      emit(StatisticsError(e.toString()));
    }
  }

  StatisticsLoaded _buildLoadedState() {
    return StatisticsLoaded(
      categories: categories
          .map((e) => {
                'text': e.categoryName,
                'value': e.totalPriceLastMonth,
                'count': e.totalQuantityLastMonth,
                'percentage': e.percentage.toString(),
              })
          .toList(),
      operatingPayments: operatingPayments
          .map((e) => {
                'text': e.name,
                'value': e.totalValue,
                'count': e.count,
                'percentage': e.percentage.toString(),
              })
          .toList(),
      doctorProfits: doctorProfits
          .map((e) => {
                'name': e.fullName,
                'value': e.totalSignedValue,
                'shadowValue': e.totalSignedValue * .1,
              })
          .toList(),
      itemMonthly: itemMonthly
          .map((e) => {
                'month': e.month,
                'value': e.negativeQuantity,
              })
          .toList(),
      itemsList: items
          .map((e) => {
                'id': e.id,
                'name': e.name,
              })
          .toList(),
    );
  }
}
