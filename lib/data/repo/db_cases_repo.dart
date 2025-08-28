import 'dart:typed_data';

import 'package:lambda_dent_dash/data/models/cases/db_case_comments.dart';
import 'package:lambda_dent_dash/data/models/cases/db_case_details.dart';
import 'package:lambda_dent_dash/data/models/cases/db_cases_list.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_commnets.dart';
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

  DBCommentsResponse? dbLabManagerProfileResponse;
  @override
  Future<List<Comment>?> getCaseComments(int id) async {
    return await DioHelper.getData(
            'lab-manager/medical-cases/show-comments/$id',
            token: CacheHelper.get('token'))
        .then((value) {
      dbLabManagerProfileResponse = DBCommentsResponse.fromJson(value?.data);
      List<DBComment>? dbComments = dbLabManagerProfileResponse!.comments;
      List<Comment> comments = [];
      if (dbComments != null) {
        if (dbComments.isNotEmpty) {
          for (var comment in dbComments) {
            comments.add(comment.toDomain());
          }
        }
      }
    }).catchError((error) {
      print('error in getComments: ' + error.toString());
      return null;
    });
  }

  @override
  Future<Uint8List>? getCasesimage(int id) async => await DioHelper.getImage(
              'lab-manager/medical-cases/download-case-image/$id',
              token: CacheHelper.get('token'))
          .then((value) {
        if (value != null && value.data['status']) {
          return value.data;
        } else {
          print(" failed: ${value?.data['message'] ?? 'Unknown error'}");
          return null;
        }
      }).catchError((error) {
        print(error.toString());
        return null;
      });

  @override
  Future<bool> addMedicalCaseToLocalClient(
      Map<String, dynamic> caseData) async {
    try {
      final response = await DioHelper.postData(
        'lab-manager/medical-cases/add-medical-case-to-local-client',
        caseData,
        token: CacheHelper.get('token'),
      );

      if (response?.data != null && response!.data['status'] == true) {
        return true;
      } else {
        print(
            'Failed to add medical case: ${response?.data['message'] ?? 'Unknown error'}');
        return false;
      }
    } catch (error) {
      print('Error adding medical case: $error');
      return false;
    }
  }

  @override
  Future<bool> postNewCase() {
    // TODO: implement postNewCase
    throw UnimplementedError();
  }

  @override
  Future<bool> postCaseComment(int caseId, String comment) async {
    try {
      final response = await DioHelper.postData(
        'lab-manager/medical-cases/add-comment/$caseId',
        {'comment': comment},
        token: CacheHelper.get('token'),
      );
      if (response?.data != null && response!.data['status'] == true) {
        return true;
      } else {
        print(
            'Failed to add comment: ${response?.data['message'] ?? 'Unknown error'}');
        return false;
      }
    } catch (error) {
      print('Error adding comment: $error');
      return false;
    }
  }
}
