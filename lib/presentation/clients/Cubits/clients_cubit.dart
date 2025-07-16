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

  MedicalCasesForDentist? casesList;
  Future<void> getCases(int id) async {
    emit(ClientsLoading());
    try {
      casesList = await repo.getcasebydocList(id);
      if (casesList != null) {
        emit(ClientsLoaded(casesList!));
      } else {
        emit(ClientsError('No cases found.'));
      }
    } on Exception catch (e) {
      emit(ClientsError("Error loading cases list: \\${e.toString()}"));
    }
  }

  DentistBillsList? dentistBillsList;
  Future<void> getDentistBills(int dentistId) async {
    emit(DentistBillsLoading());
    try {
      dentistBillsList = await repo.getDentistBills(dentistId);
      if (dentistBillsList != null) {
        emit(DentistBillsLoaded(dentistBillsList!));
      } else {
        emit(DentistBillsError('No dentist bills found.'));
      }
    } catch (e) {
      emit(DentistBillsError("Error loading dentist bills: \\${e.toString()}"));
    }
  }

  List<LabClient> labClients = [];
  Future<void> getLabClients() async {
    emit(LabClientsLoading());
    try {
      LabClientsResponse labClientsResponse = await repo.getLabClients();
      labClients = labClientsResponse.labClients;
      if (labClients.isNotEmpty) {
        emit(LabClientsLoaded(labClients));
      } else {
        emit(LabClientsError('No lab clients found.'));
      }
    } catch (e) {
      emit(LabClientsError('Error loading lab clients: \\${e.toString()}'));
    }
  }

  PreviewBillPreview? billPreview;
  Future<void> previewBill(
      {required int dentistId,
      required String dateFrom,
      required String dateTo}) async {
    emit(PreviewBillLoading());
    try {
      final response = await repo.previewBill(
          dentistId: dentistId, dateFrom: dateFrom, dateTo: dateTo);
      billPreview = response.preview;
      emit(PreviewBillLoaded(response));
    } catch (e) {
      emit(PreviewBillError('Error previewing bill: \\${e.toString()}'));
    }
  }
}
