import 'package:lambda_dent_dash/domain/repo/email_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBEmailRepo extends EmailRepo {
  @override
  Future<bool> postCheckVerificationCode(
          String guard, String email, int verificationCode) async =>
      await DioHelper.postData('auth/mails/check_verification_code', {
        'guard': 'dentist',
        'email': email,
        'verificationcode': verificationCode
      }).then((value) {
        if (value != null && value.data['status']) {
          CacheHelper.setString(
              'token', 'Bearer ' + value.data['data']['access_token']);
          print(
              "CheckVerificationCode successful. Token: ${CacheHelper.get('token')}");
          return true;
        } else {
          print(
              "CheckVerificationCode failed: ${value?.data['message'] ?? 'Unknown error'}");
          return false;
        }
      }).catchError((error) {
        print(error.toString());
        return false;
      });

  @override
  Future<bool> postForgetPass(String guard, String email, String newpass,
          String newpassconfirm) async =>
      await DioHelper.postData('auth/mails/forget-password', {
        'guard': 'dentist',
        'email': email,
        'newpass': newpass,
        'newpassconfirm': newpassconfirm,
      }).then((value) {
        if (value != null && value.data['status']) {
          CacheHelper.setString(
              'token', 'Bearer ' + value.data['data']['access_token']);
          print(" successful. Token: ${CacheHelper.get('token')}");
          return true;
        } else {
          print(" failed: ${value?.data['message'] ?? 'Unknown error'}");
          return false;
        }
      }).catchError((error) {
        print(error.toString());
        return false;
      });

  @override
  Future<bool> postStageEmp(
          String guard, String email, int verificationCode) async =>
      await DioHelper.postData('auth/stage-employee', {
        'guard': 'dentist',
        'email': email,
        'verificationcode': verificationCode
      }).then((value) {
        if (value != null && value.data['status']) {
          CacheHelper.setString(
              'token', 'Bearer ' + value.data['data']['access_token']);
          print(" successful. Token: ${CacheHelper.get('token')}");
          return true;
        } else {
          print(" failed: ${value?.data['message'] ?? 'Unknown error'}");
          return false;
        }
      }).catchError((error) {
        print(error.toString());
        return false;
      });
}
