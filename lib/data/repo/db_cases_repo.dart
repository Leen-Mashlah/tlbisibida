import 'dart:typed_data';

import 'package:dio/dio.dart';
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
    try {
      final response = await DioHelper.getData(
          'lab-manager/medical-cases/show-lab-cases-groubed-by-case-type',
          token: CacheHelper.get('token'));

      if (response?.data == null) {
        print('API response is null');
        return {
          'accepted': <MedicalCaseinList>[],
          'in_progress': <MedicalCaseinList>[],
          'pending': <MedicalCaseinList>[]
        };
      }

      dbMedicalCasesByTypeResponse =
          DBMedicalCasesByTypeResponse.fromJson(response!.data);

      if (dbMedicalCasesByTypeResponse?.medicalCasesByType == null) {
        print('Medical cases by type is null');
        return {
          'accepted': <MedicalCaseinList>[],
          'in_progress': <MedicalCaseinList>[],
          'pending': <MedicalCaseinList>[]
        };
      }

      List<MedicalCaseinList> acceptedCases = [];
      List<MedicalCaseinList> inProgressCases = [];
      List<MedicalCaseinList> pendingCases = [];

      // Safe access to accepted cases
      if (dbMedicalCasesByTypeResponse!
          .medicalCasesByType!.acceptedCases.isNotEmpty) {
        for (var medcase in dbMedicalCasesByTypeResponse!
            .medicalCasesByType!.acceptedCases) {
          acceptedCases.add(medcase.todomain());
        }
      }

      // Safe access to in progress cases
      if (dbMedicalCasesByTypeResponse!
          .medicalCasesByType!.inProgressCases.isNotEmpty) {
        for (var medcase in dbMedicalCasesByTypeResponse!
            .medicalCasesByType!.inProgressCases) {
          inProgressCases.add(medcase.todomain());
        }
      }

      // Safe access to pending cases
      if (dbMedicalCasesByTypeResponse!
          .medicalCasesByType!.pendingCases.isNotEmpty) {
        for (var medcase
            in dbMedicalCasesByTypeResponse!.medicalCasesByType!.pendingCases) {
          pendingCases.add(medcase.todomain());
        }
      }

      return {
        'accepted': acceptedCases,
        'in_progress': inProgressCases,
        'pending': pendingCases
      };
    } catch (e) {
      print('Error in getcaseList: $e');
      return {
        'accepted': <MedicalCaseinList>[],
        'in_progress': <MedicalCaseinList>[],
        'pending': <MedicalCaseinList>[]
      };
    }
  }

  DBMedicalCaseDetailsResponse? dbMedicalCaseDetailsResponse;
  @override
  Future<MedicalCase> getCaseDetails(int id) async {
    try {
      final response = await DioHelper.getData(
          'lab-manager/medical-cases/get-medical-case-details/$id',
          token: CacheHelper.get('token'));

      if (response?.data == null) {
        throw Exception('API response is null');
      }

      dbMedicalCaseDetailsResponse =
          DBMedicalCaseDetailsResponse.fromJson(response!.data);

      if (dbMedicalCaseDetailsResponse?.medicalCase == null) {
        throw Exception('Medical case is null');
      }

      MedicalCase medicalCase =
          dbMedicalCaseDetailsResponse!.medicalCase!.toDomain();
      return medicalCase;
    } catch (e) {
      print('Error in getCaseDetails: $e');
      rethrow;
    }
  }

  DBCommentsResponse? dbLabManagerProfileResponse;
  @override
  Future<List<Comment>?> getCaseComments(int id) async {
    try {
      final response = await DioHelper.getData(
          'lab-manager/medical-cases/show-comments/$id',
          token: CacheHelper.get('token'));

      if (response?.data == null) {
        print('API response is null for comments');
        return [];
      }

      dbLabManagerProfileResponse = DBCommentsResponse.fromJson(response!.data);
      List<DBComment>? dbComments = dbLabManagerProfileResponse?.comments;
      List<Comment> comments = [];

      if (dbComments != null && dbComments.isNotEmpty) {
        for (var comment in dbComments) {
          comments.add(comment.toDomain());
        }
      }

      return comments;
    } catch (error) {
      print('Error in getComments: $error');
      return [];
    }
  }

  @override
  Future<Uint8List>? getCasesimage(int id) async {
    try {
      final value = await DioHelper.getImage(
          'lab-manager/medical-cases/download-case-image/$id',
          token: CacheHelper.get('token'));

      if (value != null && value.data['status']) {
        return value.data;
      } else {
        print(
            "Image download failed: ${value?.data['message'] ?? 'Unknown error'}");
        return Future.value(null);
      }
    } catch (error) {
      print('Error downloading image: $error');
      return Future.value(null);
    }
  }

  @override
  Future<bool> addMedicalCaseToLocalClient(
      Map<String, dynamic> caseData) async {
    try {
      print('Sending case data: $caseData');

      // Convert to FormData for multipart/form-data
      final formData = FormData();

      // Add all fields to FormData
      caseData.forEach((key, value) {
        if (value != null) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      final response = await DioHelper.postFormData(
        'lab-manager/medical-cases/add-medical-case-to-local-client',
        formData,
        token: CacheHelper.get('token'),
      );

      print('Response status: ${response?.statusCode}');
      print('Response data: ${response?.data}');

      if (response?.data != null && response!.data['status'] == true) {
        return true;
      } else {
        String errorMessage = 'Unknown error';
        if (response?.data != null) {
          if (response!.data['message'] != null) {
            errorMessage = response.data['message'];
          } else if (response.data['error_message'] != null) {
            errorMessage = response.data['error_message'].toString();
          } else if (response.data['errors'] != null) {
            errorMessage = response.data['errors'].toString();
          }
        }
        print('Failed to add medical case: $errorMessage');
        return false;
      }
    } catch (error) {
      print('Error adding medical case: $error');
      if (error.toString().contains('DioException')) {
        print('DioException details: $error');
      }
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

  @override
  Future<bool> changeCaseStatus(int caseId, int cost) async {
    try {
      final response = await DioHelper.postData(
        'lab-manager/medical-cases/change-status',
        {
          'case_id': caseId,
          'cost': cost,
        },
        token: CacheHelper.get('token'),
      );

      if (response?.data != null && response!.data['status'] == true) {
        return true;
      } else {
        print(
            'Failed to change case status: ${response?.data['message'] ?? 'Unknown error'}');
        return false;
      }
    } catch (error) {
      print('Error changing case status: $error');
      return false;
    }
  }
}
