import 'package:lambda_dent_dash/data/models/auth/profile/db_lab_profile.dart';
import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';
import 'package:lambda_dent_dash/domain/repo/profile_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

class DbProfileRepo extends ProfileRepo {
  @override
  Future<bool> editProfile() {
    // TODO: implement editProfile
    throw UnimplementedError();
  }
  // await DioHelper.postData('auth/logout', {}).then((value) {
  //   if (value != null && value.data['status']) {
  //     CacheHelper.removeString('token');
  //     print("Logout successful. Token: ${CacheHelper.get('token')}");
  //     return true;
  //   } else {
  //     print("Login failed: ${value?.data['message'] ?? 'Unknown error'}");
  //     return false;
  //   }
  // }).catchError((error) {
  //   print(error.toString());
  //   return false;
  // });

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
