import 'dart:typed_data';

import 'package:lambda_dent_dash/domain/models/cases/case_commnets.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_list.dart';

abstract class CasesRepo {
  Future<MedicalCase> getCaseDetails(int id);
  Future<Map<String, List<MedicalCaseinList>>> getcaseList();
  Future<Uint8List>? getCasesimage(int id);

  Future<List<Comment>?> getCaseComments(int id);
  Future<bool> postNewCase();

  // New method for adding medical case to local client
  Future<bool> addMedicalCaseToLocalClient(Map<String, dynamic> caseData);

  // Add a comment to a medical case
  Future<bool> postCaseComment(int caseId, String comment);
}
