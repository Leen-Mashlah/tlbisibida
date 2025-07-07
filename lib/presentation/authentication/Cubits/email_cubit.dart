import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/repo/email_repo.dart';

class EmailCubit extends Cubit<String> {
  EmailCubit(this.repo) : super('');
  final EmailRepo repo;

//Check Verification Code
  bool success = false;
  Future<void> checkVerificationCode(
      String guard, String email, int verificationCode) async {
    emit('checking');
    try {
      success =
          await repo.postCheckVerificationCode(guard, email, verificationCode);
    } on Exception catch (e) {
      emit('error');
      print(e.toString());
    }
    success ? emit('checked') : emit('error');
    print(state);
  }

  //forget pass
  Future<void> forgetpass(
      String guard, String email, String newpass, String newpassconfirm) async {
    emit('checking');
    try {
      success = await repo.postForgetPass(guard, email, newpass, newpassconfirm);
    } on Exception catch (e) {
      emit('error');
      print(e.toString());
    }
    success ? emit('checked') : emit('error');
    print(state);
  }

  //stage emp
  Future<void> stageemp(
      String guard, String email, int verificationCode) async {
    emit('checking');
    try {
      success = await repo.postStageEmp(guard, email, verificationCode);
    } on Exception catch (e) {
      emit('error');
      print(e.toString());
    }
    success ? emit('checked') : emit('error');
    print(state);
  }
}
