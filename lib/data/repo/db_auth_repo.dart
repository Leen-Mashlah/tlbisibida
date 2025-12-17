import 'package:lambda_dent_dash/data/models/auth/profile/db_lab_profile.dart';
import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';
import 'package:lambda_dent_dash/domain/repo/auth_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';
import 'dart:convert';

class DBAuthRepo extends AuthRepo {
  @override
  Future<bool> postlogin(
      String email, String password, String guard, bool rememberme) async {
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
        await CacheHelper.setBool('rememberme', rememberme);
        print('Stored rememberme: ${CacheHelper.get('rememberme')}');

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
      // Some server-side validation expects certain fields (like `lab_phone`) to be
      // a JSON-encoded string. If the caller passed a List, encode it here so the
      // backend receives a string and json_decode() calls there won't error.
      if (data.containsKey('lab_phone') && data['lab_phone'] is List) {
        data['lab_phone'] = jsonEncode(data['lab_phone']);
      }

      final value = await DioHelper.postData('register', data); // Normalize server `status` which may be boolean true or string 'success'
      final resp = value?.data;
      final statusRaw = resp != null ? resp['status'] : null;
      final bool isSuccess = statusRaw == true ||
          (statusRaw is String && statusRaw.toLowerCase() == 'success');

      if (value != null && isSuccess) {
        // AWAIT this line to ensure the token is saved before you try to get it
        final accessToken = resp['data']?['access_token'];
        if (accessToken != null) {
          await CacheHelper.setString('token', 'Bearer ' + accessToken);
          print("Register successful. Token: ${CacheHelper.get('token')}");
        } else {
          print('Register successful but no access_token returned.');
        }
        return true;
      } else {
        print('Register response: ${resp}');
        final message = resp?['message'] ??
            resp?['success_message'] ??
            resp?['error'] ??
            'Unknown error';
        print("Register failed: ${message}");
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
