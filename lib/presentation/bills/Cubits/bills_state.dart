import 'package:lambda_dent_dash/domain/models/bills/bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';

abstract class BillsState {}

class BillsInitial extends BillsState {}

class BillsLoading extends BillsState {}

class BillsLoaded extends BillsState {
  final LabBillsList billsList;
  BillsLoaded(this.billsList);
}

class BillsError extends BillsState {
  final String message;
  BillsError(this.message);
}

class DentistBillsLoading extends BillsState {}

class DentistBillsLoaded extends BillsState {
  final DentistBillsList dentistBillsList;
  DentistBillsLoaded(this.dentistBillsList);
}

class DentistBillsError extends BillsState {
  final String message;
  DentistBillsError(this.message);
}
