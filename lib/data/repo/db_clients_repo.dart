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
import 'package:lambda_dent_dash/data/models/lab_clients/db_join_requests.dart';
import 'package:lambda_dent_dash/data/models/clients/db_dentist_payment.dart';
import 'package:lambda_dent_dash/domain/models/lab_clients/dentist_payment.dart';

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
  Future<ClientsResponse> getClients() async {
    DBClientsResponse? dbClientsResponse;
    await DioHelper.getData(
      'lab-manager/clients',
      token: CacheHelper.get('token'),
    ).then((value) {
      dbClientsResponse = DBClientsResponse.fromJson(value?.data);
    });
    return ClientsResponse(
      status: dbClientsResponse?.status ?? false,
      successCode: dbClientsResponse?.successCode ?? 0,
      clients: dbClientsResponse?.clients
              .map((e) => Client(
                    id: e.id,
                    name: e.name,
                    phone: e.phone,
                    address: e.address,
                    joinedOn: e.joinedOn,
                    currentAccount: e.currentAccount,
                  ))
              .toList() ??
          [],
      successMessage: dbClientsResponse?.successMessage ?? '',
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

  Future<bool> addLocalClient({
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
  }) async {
    return await DioHelper.postData(
      'lab-manager/clients/add-local-client',
      {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'address': address,
      },
      token: CacheHelper.get('token'),
    ).then((value) {
      if (value != null && value.data['status'] == true) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> approveJoinRequest(int id) async {
    return await DioHelper.postData(
      'lab-manager/join-requests/$id/approve',
      {},
      token: CacheHelper.get('token'),
    ).then((value) {
      if (value != null && value.data['status'] == true) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) {
      return false;
    });
  }

  Future<JoinRequestsResponse> getJoinRequests() async {
    DBJoinRequestsResponse? dbResp;
    await DioHelper.getData(
      'lab-manager/join-requests',
      token: CacheHelper.get('token'),
    ).then((value) {
      dbResp = DBJoinRequestsResponse.fromJson(value?.data);
    });
    return JoinRequestsResponse(
      status: dbResp?.status ?? false,
      successCode: dbResp?.successCode ?? 0,
      joinRequests: dbResp?.joinRequests
              .map((e) => JoinRequest(
                    id: e.id,
                    name: e.name,
                    phone: e.phone,
                    address: e.address,
                    requestDate: e.requestDate,
                  ))
              .toList() ??
          [],
      successMessage: dbResp?.successMessage ?? '',
    );
  }

  @override
  Future<DentistPaymentsResponse> getDentistPayments(int dentistId) async {
    try {
      final response = await DioHelper.getData(
        'lab-manager/show-dentist-payments-in-lab/$dentistId',
        token: CacheHelper.get('token'),
      );
      print('dentistId: $dentistId');
      print('response: ${response}');
      if (response?.data != null) {
        final dbResponse = DBDentistPaymentsResponse.fromJson(response!.data);
        return dbResponse.toDomain();
      } else {
        throw Exception('No response data');
      }
    } catch (e) {
      print('Error getting dentist payments: $e');
      rethrow;
    }
  }

  @override
  Future<bool> addDentistPayment(int dentistId, int value) async {
    try {
      final response = await DioHelper.postData(
        'lab-manager/add-dentist-payments-in-lab/$dentistId',
        {'value': value},
        token: CacheHelper.get('token'),
      );
      print('response: ${response}');
      if (response?.data != null && response!.data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error adding dentist payment: $e');
      return false;
    }
  }
}
