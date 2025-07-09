import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/repo/clients_repo.dart';

class ClientsCubit extends Cubit<String> {
  ClientsCubit(this.repo) : super('initial') {
    // getCases();
  }

  final ClientsRepo repo;

  MedicalCasesForDentist? casesList;
  Future<void> getCases(int id) async {
    emit('client_cases_list_loading');
    try {
      casesList = await repo.getcasebydocList(id);
    } on Exception catch (e) {
      emit('error');
      print("Error loading cases list: ${e.toString()}");
    }
    if (casesList != null) {
      emit('client_case_list_loaded');
    } else {
      emit('error');
    }
    print("Client's Case List state: $state, Cases: $casesList");
  }
}
