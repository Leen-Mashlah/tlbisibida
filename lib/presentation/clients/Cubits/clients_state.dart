import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/lab_clients/lab_client.dart';
import 'package:lambda_dent_dash/domain/models/bills/preview_bill.dart';

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

class LabClientsLoading extends ClientsState {}

class LabClientsLoaded extends ClientsState {
  final List<LabClient> labClients;
  LabClientsLoaded(this.labClients);
}

class LabClientsError extends ClientsState {
  final String message;
  LabClientsError(this.message);
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
