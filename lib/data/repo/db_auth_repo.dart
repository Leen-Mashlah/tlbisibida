import 'package:dio/dio.dart';
import 'package:lambda_dent_dash/data/models/auth/profile/db_lab_profile.dart';
import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';
import 'package:lambda_dent_dash/domain/repo/auth_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DBAuthRepo extends AuthRepo {
  Future<bool> postlogin(String email, String password, String guard) async {
    try {
      final response = await DioHelper.postData(
        'login',
        {'email': email, 'password': password, 'guard': guard},
      );

      if (response != null && response.data['status']) {
        print('response: ' + response.data.toString());
        final tokenValue = 'Bearer ' + response.data['data']['access_token'];
        print('DBAuthRepo - Storing token: ${tokenValue.substring(0, 20)}...');
        // AWAIT this line to ensure the token is saved before you try to get it
        await CacheHelper.setString('token', tokenValue);
        final retrievedToken = CacheHelper.get('token');
        print(
            "Login successful. Token stored: ${retrievedToken != null ? 'Yes' : 'No'}");
        print(
            "Login successful. Token value: ${retrievedToken?.toString().substring(0, 20)}...");
        return true;
      } else {
        print("Login failed: ${response?.data ?? 'Unknown error'}");
        return false;
      }
    } catch (error) {
      print("PostLogin Error: " + error.toString());
      rethrow;
    }
  }

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
        // AWAIT this line to ensure the token is saved before you try to get it
        await CacheHelper.setString(
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
      print(value?.data);
      dblLabProfileResponse = DBLabProfileResponse.fromJson(value?.data);
      print(dblLabProfileResponse?.profile?.LabProfileDetails?.fullName);
    });
    LabProfile profile = dblLabProfileResponse!.profile!.toDomain();

    return profile;
  }
}
