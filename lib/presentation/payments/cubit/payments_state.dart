import 'package:lambda_dent_dash/domain/models/payments/lab_item_history.dart';

abstract class PaymentsState {}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoading extends PaymentsState {}

class PaymentsLoaded extends PaymentsState {
  final List<LabItemHistory> labItemsHistory;
  PaymentsLoaded(this.labItemsHistory);
}

class PaymentsError extends PaymentsState {
  final String message;
  PaymentsError(this.message);
}

// Operating payments states
class PaymentsOpLoading extends PaymentsState {}

class PaymentsOpLoaded extends PaymentsState {
  final List<dynamic>
      operatingItems; // items of OperatingPaymentItem from cubit
  PaymentsOpLoaded(this.operatingItems);
}

class PaymentsOpSubmitting extends PaymentsState {}

class PaymentsOpError extends PaymentsState {
  final String message;
  PaymentsOpError(this.message);
}
