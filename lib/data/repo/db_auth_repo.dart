import 'package:dio/dio.dart';
import 'package:lambda_dent_dash/data/models/auth/profile/db_lab_profile.dart';
import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';
import 'package:lambda_dent_dash/domain/repo/auth_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBAuthRepo extends AuthRepo {
  @override
  Future<bool> postlogin(String email, String password, String guard) async =>
      await DioHelper.postData(
              'login', {'email': email, 'password': password, 'guard': guard})
          .then((value) {
        if (value != null && value.data['status']) {
          CacheHelper.setString(
              'token', 'Bearer ' + value.data['data']['access_token']);
          print("Login successful. Token: ${CacheHelper.get('token')}");
          return true;
        } else {
          print("Login failed: ${value?.data ?? 'Unknown error'}");
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
  Future<bool> postregister(Map<String, dynamic> data) async {
    try {
      final value = await DioHelper.postData('register', data);
      if (value != null && value.data['status'] == true) {
        CacheHelper.setString(
            'token', 'Bearer ' + value.data['data']['access_token']);
        print("Register successful. Token: ${CacheHelper.get('token')}");
        return true;
      } else {
        print('Register response: ${value?.data}');
        print("Register failed: ${value?.data['message'] ?? 'Unknown error'}");
        return false;
      }
    } catch (error) {
      print('Register error: $error');
      return false;
    }
  }

  @override
  Future<bool> postrefreshtoken() {
    // TODO: implement postrefreshtoken
    throw UnimplementedError();
  }

  DBLabProfileResponse? dblLabProfileResponse;
  @override
  Future<LabProfile> getProfile() async {
    await DioHelper.getData('auth/profile', token: CacheHelper.get('token'))
        .then((value) {
      dblLabProfileResponse = DBLabProfileResponse.fromJson(value?.data);
    });
    LabProfile profile = dblLabProfileResponse!.profile!.toDomain();

    return profile;
  }
}
