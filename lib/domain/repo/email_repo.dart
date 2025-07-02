abstract class EmailRepo {
  Future<bool> postCheckVerificationCode(
      String guard, String email, int verificationCode);
  Future<bool> postForgetPass(
      String guard, String email, String newpass, String newpassconfirm);
  Future<bool> postStageEmp(String guard, String email, int verificationCode);
}
