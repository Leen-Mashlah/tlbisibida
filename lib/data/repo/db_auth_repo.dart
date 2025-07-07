import 'package:lambda_dent_dash/data/models/auth/profile/db_lab_profile.dart';
import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';
import 'package:lambda_dent_dash/domain/repo/auth_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBAuthRepo extends AuthRepo {
  @override
  Future<bool> postlogin(String email, String password, String guard) async =>
      await DioHelper.postData('login', {
        'email': email,
        'password': password,
        'guard': 'dentist'
      }).then((value) {
        if (value != null && value.data['status']) {
          CacheHelper.setString(
              'token', 'Bearer ' + value.data['data']['access_token']);
          print("Login successful. Token: ${CacheHelper.get('token')}");
          return true;
        } else {
          print("Login failed: ${value?.data['message'] ?? 'Unknown error'}");
          return false;
        }
      }).catchError((error) {
        print(error.toString());
        return false;
      });

  @override
  Future<bool> postlogout() async =>
      await DioHelper.postData('auth/logout', {}).then((value) {
        if (value != null && value.data['status']) {
          CacheHelper.removeString('token');
          print("Logout successful. Token: ${CacheHelper.get('token')}");
          return true;
        } else {
          print("Login failed: ${value?.data['message'] ?? 'Unknown error'}");
          return false;
        }
      }).catchError((error) {
        print(error.toString());
        return false;
      });

  @override
  Future<bool> postregister(Map<String, dynamic> data) async =>
      await DioHelper.postData('register', data).then((value) {
        if (value != null && value.data['status']) {
          CacheHelper.setString(
              'token', 'Bearer ' + value.data['data']['access_token']);
          print("Register successful. Token: ${CacheHelper.get('token')}");
          return true;
        } else {
          print(
              "Register failed: ${value?.data['message'] ?? 'Unknown error'}");
          return false;
        }
      }).catchError((error) {
        print(error.toString());
        return false;
      });

  @override
  Future<bool> postrefreshtoken() {
    // TODO: implement postrefreshtoken
    throw UnimplementedError();
  }


    DBLabManagerProfileResponse? dbLabManagerProfileResponse;
  @override
  Future<LabProfile> getProfile() async {
    await DioHelper.getData('auth/profile', token: CacheHelper.get('token'))
        .then((value) {
      dbLabManagerProfileResponse =
          DBLabManagerProfileResponse.fromJson(value?.data);
    });
    LabProfile profile = dbLabManagerProfileResponse!.profile!.todomain();

    return profile;
  }
}
