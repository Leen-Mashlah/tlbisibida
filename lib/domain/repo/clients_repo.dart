import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';

abstract class ClientsRepo {
  Future<MedicalCasesForDentist> getcasebydocList(int id);
  Future<DentistBillsList> getDentistBills(int dentistId);
}
