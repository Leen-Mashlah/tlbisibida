import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/payments/lab_item_history.dart';
import 'package:lambda_dent_dash/domain/repo/payments_repo.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/payments_state.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this.repo) : super(PaymentsInitial());

  final PaymentsRepo? repo;

  List<LabItemHistory> labItemsHistory = [];
  // Operating payments items
  List<OperatingPaymentItem> operatingItems = [];

  Future<void> loadLabItemsHistory() async {
    if (isClosed) return;
    emit(PaymentsLoading());
    try {
      labItemsHistory = await (repo?.getLabItemsHistory() ?? Future.value([]));
      if (isClosed) return;
      emit(PaymentsLoaded(labItemsHistory));
    } catch (e) {
      if (!isClosed) emit(PaymentsError(e.toString()));
    }
  }

  Future<void> fetchOperatingPayments() async {
    if (isClosed) return;
    emit(PaymentsOpLoading());
    try {
      final response = await DioHelper.getData('operating-payments/get-all',
          token: CacheHelper.get('token'));
      final data = response?.data;
      final list = (data?['operating_payments'] as List?) ?? [];
      operatingItems =
          list.map((e) => OperatingPaymentItem.fromJson(e)).toList();
      if (isClosed) return;
      emit(PaymentsOpLoaded(operatingItems));
    } catch (e) {
      if (isClosed) return;
      emit(PaymentsOpError(e.toString()));
    }
  }

  Future<bool> addOperatingPayment(
      {required String name, required String value}) async {
    if (isClosed) return false;
    emit(PaymentsOpSubmitting());
    try {
      final response = await DioHelper.postData(
          'operating-payments/add',
          {
            'name': name,
            'value': value,
          },
          token: CacheHelper.get('token'));
      final ok = response?.data != null && (response!.data['status'] == true);
      if (ok) {
        await fetchOperatingPayments();
        return true;
      }
      if (!isClosed) {
        emit(
            PaymentsOpError(response?.data['message']?.toString() ?? 'Failed'));
      }
      return false;
    } catch (e) {
      if (!isClosed) emit(PaymentsOpError(e.toString()));
      return false;
    }
  }
}

class OperatingPaymentItem {
  final int id;
  final String name;
  final num value;
  final String createdAt;
  OperatingPaymentItem(
      {required this.id,
      required this.name,
      required this.value,
      required this.createdAt});
  factory OperatingPaymentItem.fromJson(Map<String, dynamic> json) {
    return OperatingPaymentItem(
        id: json['id'] ?? 0,
        name: json['name']?.toString() ?? '',
        value: json['value'] ?? 0,
        createdAt: json['created_at']?.toString() ?? '');
  }
}
