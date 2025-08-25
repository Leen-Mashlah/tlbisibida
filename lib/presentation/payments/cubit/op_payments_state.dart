import 'package:lambda_dent_dash/presentation/payments/cubit/op_payments_cubit.dart';

abstract class OperatingPaymentsState {}

class OperatingPaymentsInitial extends OperatingPaymentsState {}

class OperatingPaymentsLoading extends OperatingPaymentsState {}

class OperatingPaymentsLoaded extends OperatingPaymentsState {
  final List<OperatingPaymentItem> items;
  OperatingPaymentsLoaded(this.items);
}

class OperatingPaymentsSubmitting extends OperatingPaymentsState {}

class OperatingPaymentsError extends OperatingPaymentsState {
  final String message;
  OperatingPaymentsError(this.message);
}

