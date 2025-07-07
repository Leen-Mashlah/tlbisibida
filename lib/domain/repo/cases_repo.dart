import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_list.dart';

abstract class CasesRepo {
  Future<MedicalCase> getCaseDetails(int id);
  Future<Map<String, List<MedicalCaseinList>>> getcaseList();

  Future<void> getCaseComments();
  Future<bool> postNewCase();
}
