import 'package:lambda_dent_dash/domain/models/lab_clients/lab_client.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/preview_bill.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/clients/dentist_payment.dart';

abstract class ClientsState {}

class ClientsInitial extends ClientsState {}

class ClientsLoading extends ClientsState {}

class RequestsLoading extends ClientsState {}

class RequestsLoaded extends ClientsState {}

class ClientsLoaded extends ClientsState {
  final ClientsResponse clientsResponse;
  ClientsLoaded(this.clientsResponse);
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

class PreviewBillLoading extends ClientsState {}

class PreviewBillLoaded extends ClientsState {
  final PreviewBillResponse previewBillResponse;
  PreviewBillLoaded(this.previewBillResponse);
}

class PreviewBillError extends ClientsState {
  final String message;
  PreviewBillError(this.message);
}

class ClientCasesLoading extends ClientsState {}

class ClientCasesLoaded extends ClientsState {
  final List<DentistCase> cases;
  ClientCasesLoaded(this.cases);
}

class ClientCasesError extends ClientsState {
  final String message;
  ClientCasesError(this.message);
}

// Dentist payments states
class DentistPaymentsLoading extends ClientsState {}

class DentistPaymentsLoaded extends ClientsState {
  final DentistPaymentsResponse dentistPaymentsResponse;
  DentistPaymentsLoaded(this.dentistPaymentsResponse);
}

class DentistPaymentsError extends ClientsState {
  final String message;
  DentistPaymentsError(this.message);
}

// Separate states for adding payments
class DentistPaymentAdding extends ClientsState {}

class DentistPaymentAdded extends ClientsState {
  final DentistPaymentsResponse dentistPaymentsResponse;
  DentistPaymentAdded(this.dentistPaymentsResponse);
}

class DentistPaymentAddError extends ClientsState {
  final String message;
  DentistPaymentAddError(this.message);
}
