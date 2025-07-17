import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';

abstract class AuthRepo {
  Future<bool> postlogin(String email, String password, String guard);
  Future<bool> postlogout();
  Future<bool> postregister(Map<String, dynamic> data);
  Future<bool> postrefreshtoken();
  Future<LabProfile> getProfile();
}
