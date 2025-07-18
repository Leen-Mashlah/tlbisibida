import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart'
    as dentist_model;
import 'package:lambda_dent_dash/domain/models/lab_clients/lab_client.dart';
import 'package:lambda_dent_dash/domain/models/bills/preview_bill.dart';

abstract class ClientsRepo {
  Future<MedicalCasesForDentist> getcasebydocList(int id);
  Future<dentist_model.DentistBillsList> getDentistBills(int dentistId);
  Future<LabClientsResponse> getLabClients();
  Future<PreviewBillResponse> previewBill(
      {required int dentistId,
      required String dateFrom,
      required String dateTo});
}
