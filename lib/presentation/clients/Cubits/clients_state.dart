import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';

abstract class ClientsState {}

class ClientsInitial extends ClientsState {}

class ClientsLoading extends ClientsState {}

class RequestsLoading extends ClientsState {}

class RequestsLoaded extends ClientsState {}

class ClientsLoaded extends ClientsState {
  final MedicalCasesForDentist casesList;
  ClientsLoaded(this.casesList);
}

class ClientsError extends ClientsState {
  final String message;
  ClientsError(this.message);
}

class DentistBillsLoading extends ClientsState {}

class DentistBillsLoaded extends ClientsState {
  final DentistBillsList dentistBillsList;
  DentistBillsLoaded(this.dentistBillsList);
}

class DentistBillsError extends ClientsState {
  final String message;
  DentistBillsError(this.message);
}
