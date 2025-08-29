import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/bills/preview_bill.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/repo/clients_repo.dart';
import 'package:lambda_dent_dash/domain/models/lab_clients/lab_client.dart';
import 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.repo) : super(ClientsInitial());

  final ClientsRepo repo;

  // Loading guards
  bool _isLoadingClients = false;
  bool _hasLoadedClients = false;

  MedicalCasesForDentist? casesList;
  Future<void> getCases(int id) async {
    if (isClosed) return;
    emit(ClientCasesLoading());
    try {
      final casesForDentist = await repo.getcasebydocList(id);
      if (casesForDentist.dentistCases.isNotEmpty) {
        if (isClosed) return;
        emit(ClientCasesLoaded(casesForDentist.dentistCases));
      } else {
        if (!isClosed) emit(ClientCasesError('No cases found.'));
      }
    } catch (e) {
      if (!isClosed) {
        emit(ClientCasesError('Error loading cases list: \\${e.toString()}'));
      }
    }
  }

  DentistBillsList? dentistBillsList;
  Future<void> getDentistBills(int dentistId) async {
    if (isClosed) return;
    emit(DentistBillsLoading());
    try {
      dentistBillsList = await repo.getDentistBills(dentistId);
      if (dentistBillsList != null) {
        if (isClosed) return;
        emit(DentistBillsLoaded(dentistBillsList!));
      } else {
        if (!isClosed) emit(DentistBillsError('No dentist bills found.'));
      }
    } catch (e) {
      if (!isClosed)
        emit(DentistBillsError(
            "Error loading dentist bills: \\${e.toString()}"));
    }
  }

  PreviewBillPreview? billPreview;
  Future<void> previewBill(
      {required int dentistId,
      required String dateFrom,
      required String dateTo}) async {
    if (isClosed) return;
    emit(PreviewBillLoading());
    try {
      final response = await repo.previewBill(
          dentistId: dentistId, dateFrom: dateFrom, dateTo: dateTo);
      billPreview = response.preview;
      if (isClosed) return;
      emit(PreviewBillLoaded(response));
    } catch (e) {
      if (!isClosed)
        emit(PreviewBillError('Error previewing bill: \\${e.toString()}'));
    }
  }

  ClientsResponse? clientsResponse;
  Future<void> getClients() async {
    if (isClosed) return;
    if (_isLoadingClients || _hasLoadedClients) return;
    _isLoadingClients = true;
    emit(ClientsLoading());
    try {
      clientsResponse = await repo.getClients();
      if (clientsResponse != null && clientsResponse!.clients.isNotEmpty) {
        if (isClosed) return;
        emit(ClientsLoaded(clientsResponse!));
        _hasLoadedClients = true;
      } else {
        if (!isClosed) emit(ClientsError('No clients found.'));
      }
    } catch (e) {
      if (!isClosed) {
        emit(ClientsError('Error loading clients: \\${e.toString()}'));
      }
    } finally {
      _isLoadingClients = false;
    }
  }

  Future<bool> addLocalClient({
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
  }) async {
    if (isClosed) return false;
    emit(ClientsLoading());
    try {
      final success = await repo.addLocalClient(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address,
      );
      if (success) {
        await getClients();
      } else {
        if (!isClosed) emit(ClientsError('Failed to add client.'));
      }
      return success;
    } catch (e) {
      if (!isClosed)
        emit(ClientsError('Error adding client: \\${e.toString()}'));
      return false;
    }
  }

  Future<bool> approveJoinRequest(int id) async {
    if (isClosed) return false;
    emit(ClientsLoading());
    try {
      final success = await repo.approveJoinRequest(id);
      if (success) {
        await getJoinRequests();
        await getClients();
      } else {
        if (!isClosed) emit(ClientsError('Failed to approve join request.'));
      }
      return success;
    } catch (e) {
      if (!isClosed)
        emit(ClientsError('Error approving join request: \\${e.toString()}'));
      return false;
    }
  }

  JoinRequestsResponse? joinRequestsResponse;
  Future<void> getJoinRequests() async {
    if (isClosed) return;
    emit(RequestsLoading());
    try {
      joinRequestsResponse = await repo.getJoinRequests();
      if (isClosed) return;
      emit(RequestsLoaded());
    } catch (e) {
      if (!isClosed)
        emit(ClientsError('Error loading join requests: \\${e.toString()}'));
    }
  }
}
