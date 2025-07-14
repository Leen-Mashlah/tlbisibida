import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/repo/clients_repo.dart';
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
}
