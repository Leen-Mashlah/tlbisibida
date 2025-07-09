import 'package:lambda_dent_dash/domain/models/cases/cases_by_doc.dart';

abstract class ClientsRepo {
  Future<MedicalCasesForDentist> getcasebydocList(int id);
}
