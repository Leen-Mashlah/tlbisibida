
import 'package:lambda_dent_dash/data/models/cases/db_case_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/repo/clients_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBClientsRepo extends ClientsRepo {
  DBMedicalCasesForDentistResponse? dbMedicalCasesForDentistResponse;
  @override
  Future<MedicalCasesForDentist> getcasebydocList(int id) async {
    await DioHelper.getData(
            'lab-manager/medical-cases/dentist-cases-by-created-date-descending/$id',
            token: CacheHelper.get('token'))
        .then((value) {
      dbMedicalCasesForDentistResponse =
          DBMedicalCasesForDentistResponse.fromJson(value?.data);
    });
    MedicalCasesForDentist medicalCasesForDentist =
        dbMedicalCasesForDentistResponse!.medicalCasesForDentist!.toDomain();
    return medicalCasesForDentist;
  }
}
