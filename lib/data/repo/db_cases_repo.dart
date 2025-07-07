import 'package:lambda_dent_dash/data/models/cases/db_case_details.dart';
import 'package:lambda_dent_dash/data/models/cases/db_cases_list.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_list.dart';
import 'package:lambda_dent_dash/domain/repo/cases_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBCasesRepo extends CasesRepo {
  DBMedicalCasesByTypeResponse? dbMedicalCasesByTypeResponse;
  @override
  Future<Map<String, List<MedicalCaseinList>>> getcaseList() async {
    await DioHelper.getData(
            'lab-manager/medical-cases/show-lab-cases-groubed-by-case-type',
            token: CacheHelper.get('token'))
        .then((value) {
      dbMedicalCasesByTypeResponse =
          DBMedicalCasesByTypeResponse.fromJson(value?.data);
    });

    List<MedicalCaseinList> acceptedCases = [];
    List<MedicalCaseinList> inProgressCases = [];
    List<MedicalCaseinList> pendingCases = [];
    for (var medcase
        in dbMedicalCasesByTypeResponse!.medicalCasesByType!.acceptedCases) {
      acceptedCases.add(medcase.todomain());
    }
    for (var medcase
        in dbMedicalCasesByTypeResponse!.medicalCasesByType!.inProgressCases) {
      inProgressCases.add(medcase.todomain());
    }
    for (var medcase
        in dbMedicalCasesByTypeResponse!.medicalCasesByType!.pendingCases) {
      pendingCases.add(medcase.todomain());
    }
    return {
      'accepted': acceptedCases,
      'in_progress': inProgressCases,
      'pending': pendingCases
    };
  }

  DBMedicalCaseDetailsResponse? dbMedicalCaseDetailsResponse;
  @override
  Future<MedicalCase> getCaseDetails(int id) async {
    await DioHelper.getData(
            'lab-manager/medical-cases/get-medical-case-details/$id',
            token: CacheHelper.get('token'))
        .then((value) {
      dbMedicalCaseDetailsResponse =
          DBMedicalCaseDetailsResponse.fromJson(value?.data);
    });
    MedicalCase medicalCase =
        dbMedicalCaseDetailsResponse!.medicalCase!.toDomain();
    return medicalCase;
  }

  @override
  Future<void> getCaseComments() {
    //TODO
        throw UnimplementedError();
  }

  @override
  Future<bool> postNewCase() {
    // TODO: implement postNewCase
    throw UnimplementedError();
  }
}
