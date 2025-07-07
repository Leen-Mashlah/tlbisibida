import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_list.dart';
import 'package:lambda_dent_dash/domain/repo/cases_repo.dart';

class CasesCubit extends Cubit<String> {
  CasesCubit(this.repo) : super('initial') {
    getCases();
  }

  final CasesRepo repo;

  Map<String, List<MedicalCaseinList>>? casesList;
  Future<void> getCases() async {
    emit('cases_list_loading');
    try {
      casesList = await repo.getcaseList();
    } on Exception catch (e) {
      emit('error');
      print("Error loading cases list: ${e.toString()}");
    }
    if (casesList != null) {
      emit('case_list_loaded');
    } else {
      emit('error');
    }
    print("Case List state: $state, Profile: $casesList");
  }

  MedicalCase? medicalCase;
  Future<void> getCaseDetails(int id) async {
    emit('case_loading');
    try {
      medicalCase = await repo.getCaseDetails(id);
    } on Exception catch (e) {
      emit('error');
      print("Error loading case: ${e.toString()}");
    }
    if (medicalCase != null) {
      emit('case_loaded');
    } else {
      emit('error');
    }
    print("Case Details state: $state, Profile: $medicalCase");
  }
}
