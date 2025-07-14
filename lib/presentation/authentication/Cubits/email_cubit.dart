import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/repo/email_repo.dart';
import 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit(this.repo) : super(EmailInitial());
  final EmailRepo repo;

  bool success = false;
  Future<void> checkVerificationCode(
      String guard, String email, int verificationCode) async {
    emit(EmailChecking());
    try {
      success =
          await repo.postCheckVerificationCode(guard, email, verificationCode);
      if (success) {
        emit(EmailChecked());
      } else {
        emit(EmailError('Verification failed.'));
      }
    } catch (e) {
      emit(EmailError(e.toString()));
    }
  }

  Future<void> forgetpass(
      String guard, String email, String newpass, String newpassconfirm) async {
    emit(EmailChecking());
    try {
      success =
          await repo.postForgetPass(guard, email, newpass, newpassconfirm);
      if (success) {
        emit(EmailChecked());
      } else {
        emit(EmailError('Password reset failed.'));
      }
    } catch (e) {
      emit(EmailError(e.toString()));
    }
  }

  Future<void> stageemp(
      String guard, String email, int verificationCode) async {
    emit(EmailChecking());
    try {
      success = await repo.postStageEmp(guard, email, verificationCode);
      if (success) {
        emit(EmailChecked());
      } else {
        emit(EmailError('Stage emp failed.'));
      }
    } catch (e) {
      emit(EmailError(e.toString()));
    }
  }
}
