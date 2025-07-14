import 'package:lambda_dent_dash/data/models/bills/db_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/bills_list.dart';
import 'package:lambda_dent_dash/domain/repo/bills_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';
import 'package:lambda_dent_dash/data/models/bills/db_dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';

class DBBillsRepo extends BillsRepo {
  DBLabBillsListResponse? dbLabBillsListResponse;
  @override
  Future<LabBillsList> getLabBills() async {
    await DioHelper.getData(
      'lab-manager/bills/show-lab-bills',
      token: CacheHelper.get('token'),
    ).then((value) {
      dbLabBillsListResponse = DBLabBillsListResponse.fromJson(value?.data);
    });
    return LabBillsList(
      bills: dbLabBillsListResponse?.bills?.map((e) => e.toDomain()).toList() ??
          [],
      status: dbLabBillsListResponse?.status ?? false,
      successCode: dbLabBillsListResponse?.successCode ?? 0,
      successMessage: dbLabBillsListResponse?.successMessage ?? '',
    );
  }

  @override
  Future<DentistBillsList> getDentistBills(int dentistId) async {
    DBDentistBillsListResponse? dbDentistBillsListResponse;
    await DioHelper.getData(
      'lab-manager/bills/show-dentist-bills/$dentistId',
      token: CacheHelper.get('token'),
    ).then((value) {
      dbDentistBillsListResponse =
          DBDentistBillsListResponse.fromJson(value?.data);
    });
    return DentistBillsList(
      bills: dbDentistBillsListResponse?.bills
              ?.map((e) => e.toDomain())
              .toList() ??
          [],
      dentist: dbDentistBillsListResponse?.dentist?.toDomain() ??
          DentistinBill(
              id: 0, firstName: '', lastName: '', phone: 0, address: ''),
      currentBalance: dbDentistBillsListResponse?.currentBalance?.toDomain() ??
          DentistCurrentBalance(currentAccount: 0),
      status: dbDentistBillsListResponse?.status ?? false,
      successCode: dbDentistBillsListResponse?.successCode ?? 0,
      successMessage: dbDentistBillsListResponse?.successMessage ?? '',
    );
  }
}
