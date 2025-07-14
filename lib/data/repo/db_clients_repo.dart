import 'package:lambda_dent_dash/data/models/cases/db_case_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/repo/clients_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';
import 'package:lambda_dent_dash/data/models/bills/db_dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart'
    as dentist_model;

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

  @override
  Future<dentist_model.DentistBillsList> getDentistBills(int dentistId) async {
    DBDentistBillsListResponse? dbDentistBillsListResponse;
    await DioHelper.getData(
      'lab-manager/bills/show-dentist-bills/$dentistId',
      token: CacheHelper.get('token'),
    ).then((value) {
      dbDentistBillsListResponse =
          DBDentistBillsListResponse.fromJson(value?.data);
    });
    return dentist_model.DentistBillsList(
      bills: dbDentistBillsListResponse?.bills
              ?.map((e) => e.toDomain())
              .toList() ??
          [],
      dentist: dbDentistBillsListResponse?.dentist?.toDomain() ??
          dentist_model.DentistinBill(
              id: 0, firstName: '', lastName: '', phone: 0, address: ''),
      currentBalance: dbDentistBillsListResponse?.currentBalance?.toDomain() ??
          dentist_model.DentistCurrentBalance(currentAccount: 0),
      status: dbDentistBillsListResponse?.status ?? false,
      successCode: dbDentistBillsListResponse?.successCode ?? 0,
      successMessage: dbDentistBillsListResponse?.successMessage ?? '',
    );
  }
}
