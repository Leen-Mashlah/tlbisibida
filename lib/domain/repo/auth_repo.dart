abstract class AuthRepo {
  Future<bool> postlogin(String email, String password, String guard);
  Future<bool> postlogout();
  Future<bool> postregister(Map<String, dynamic> data);
  Future<bool> postrefreshtoken();
}
