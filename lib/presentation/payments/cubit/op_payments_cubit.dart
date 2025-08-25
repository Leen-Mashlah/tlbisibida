import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/op_payments_state.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

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

class OperatingPaymentsCubit extends Cubit<OperatingPaymentsState> {
  OperatingPaymentsCubit() : super(OperatingPaymentsInitial());

  List<OperatingPaymentItem> items = [];

  Future<void> fetchOperatingPayments() async {
    emit(OperatingPaymentsLoading());
    try {
      final response = await DioHelper.getData('operating-payments/get-all',
          token: CacheHelper.get('token'));
      final data = response?.data;
      final list = (data?['operating_payments'] as List?) ?? [];
      items = list.map((e) => OperatingPaymentItem.fromJson(e)).toList();
      emit(OperatingPaymentsLoaded(items));
    } catch (e) {
      emit(OperatingPaymentsError(e.toString()));
    }
  }

  Future<bool> addOperatingPayment(
      {required String name, required String value}) async {
    emit(OperatingPaymentsSubmitting());
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
      emit(OperatingPaymentsError(
          response?.data['message']?.toString() ?? 'Failed'));
      return false;
    } catch (e) {
      emit(OperatingPaymentsError(e.toString()));
      return false;
    }
  }
}

