import 'package:lambda_dent_dash/data/models/cases/db_case_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/repo/clients_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';
import 'package:lambda_dent_dash/data/models/bills/db_dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart'
    as dentist_model;
import 'package:lambda_dent_dash/data/models/lab_clients/db_lab_client.dart';
import 'package:lambda_dent_dash/domain/models/lab_clients/lab_client.dart';
import 'package:lambda_dent_dash/data/models/bills/db_preview_bill.dart';
import 'package:lambda_dent_dash/domain/models/bills/preview_bill.dart';

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

  @override
  Future<LabClientsResponse> getLabClients() async {
    DBLabClientsResponse? dbLabClientsResponse;
    await DioHelper.getData(
      'lab-manager/medical-cases/show-lab-clients',
      token: CacheHelper.get('token'),
    ).then((value) {
      dbLabClientsResponse = DBLabClientsResponse.fromJson(value?.data);
    });
    return LabClientsResponse(
      status: dbLabClientsResponse?.status ?? false,
      successCode: dbLabClientsResponse?.successCode ?? 0,
      labClients: dbLabClientsResponse?.labClients
              .map((e) => LabClient(
                    id: e.id,
                    firstName: e.firstName,
                    lastName: e.lastName,
                    email: e.email,
                    registerSubscriptionDuration:
                        e.registerSubscriptionDuration,
                    phone: e.phone,
                    address: e.address,
                    emailVerifiedAt: e.emailVerifiedAt,
                    emailIsVerified: e.emailIsVerified,
                    verificationCode: e.verificationCode,
                    imagePath: e.imagePath,
                    registerAccepted: e.registerAccepted,
                    registerDate: e.registerDate,
                    subscriptionIsValidNow: e.subscriptionIsValidNow,
                    createdAt: e.createdAt,
                    updatedAt: e.updatedAt,
                  ))
              .toList() ??
          [],
      successMessage: dbLabClientsResponse?.successMessage ?? '',
    );
  }

  @override
  Future<PreviewBillResponse> previewBill(
      {required int dentistId,
      required String dateFrom,
      required String dateTo}) async {
    DBPreviewBillResponse? dbPreviewBillResponse;
    await DioHelper.postData(
      'lab-manager/bills/preview-bill',
      {
        'dentist_id': dentistId,
        'date_from': dateFrom,
        'date_to': dateTo,
      },
      token: CacheHelper.get('token'),
    ).then((value) {
      dbPreviewBillResponse = DBPreviewBillResponse.fromJson(value?.data);
    });
    return PreviewBillResponse(
      status: dbPreviewBillResponse?.status ?? false,
      successCode: dbPreviewBillResponse?.successCode ?? 0,
      preview: PreviewBillPreview(
        medicalCases: dbPreviewBillResponse?.preview.medicalCases
                .map((e) => PreviewBillMedicalCase(
                      id: e.id,
                      patientId: e.patientId,
                      dentistId: e.dentistId,
                      labManagerId: e.labManagerId,
                      expectedDeliveryDate: e.expectedDeliveryDate,
                      status: e.status,
                      cost: e.cost,
                      createdAt: e.createdAt,
                      patient: PreviewBillPatient(
                        id: e.patient.id,
                        fullName: e.patient.fullName,
                      ),
                    ))
                .toList() ??
            [],
        totalBillCost: dbPreviewBillResponse?.preview.totalBillCost ?? 0,
      ),
      successMessage: dbPreviewBillResponse?.successMessage ?? '',
    );
  }
}
