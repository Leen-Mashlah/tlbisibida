import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/repo/email_repo.dart';
import 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit(this.repo) : super(EmailInitial());
  final EmailRepo repo;

  bool success = false;
  Future<void> checkVerificationCode(
      String guard, String email, int verificationCode) async {
    if (isClosed) return;
    emit(EmailChecking());
    try {
      success =
          await repo.postCheckVerificationCode(guard, email, verificationCode);
      if (success) {
        if (isClosed) return;
        emit(EmailChecked());
      } else {
        if (!isClosed) emit(EmailError('Verification failed.'));
      }
    } catch (e) {
      if (!isClosed) emit(EmailError(e.toString()));
    }
  }

  Future<void> forgetpass(
      String guard, String email, String newpass, String newpassconfirm) async {
    if (isClosed) return;
    emit(EmailChecking());
    try {
      success =
          await repo.postForgetPass(guard, email, newpass, newpassconfirm);
      if (success) {
        if (isClosed) return;
        emit(EmailChecked());
      } else {
        if (!isClosed) emit(EmailError('Password reset failed.'));
      }
    } catch (e) {
      if (!isClosed) emit(EmailError(e.toString()));
    }
  }

  Future<void> stageemp(
      String guard, String email, int verificationCode) async {
    if (isClosed) return;
    emit(EmailChecking());
    try {
      success = await repo.postStageEmp(guard, email, verificationCode);
      if (success) {
        if (isClosed) return;
        emit(EmailChecked());
      } else {
        if (!isClosed) emit(EmailError('Stage emp failed.'));
      }
    } catch (e) {
      if (!isClosed) emit(EmailError(e.toString()));
    }
  }
}
