import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';
import 'package:lambda_dent_dash/domain/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repo) : super(AuthInitial());
  final AuthRepo repo;

  bool success = false;
  String? lastErrorMessage;

  Future<void> login(String email, String password, String guard) async {
    emit(AuthLoading());
    try {
      success = await repo.postlogin(email, password, guard);
      if (success) {
        emit(AuthLoggedIn());
      } else {
        lastErrorMessage = 'Login failed. Please check your credentials.';
        emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      emit(AuthError(lastErrorMessage!));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      success = await repo.postlogout();
      if (success) {
        emit(AuthLoggedOut());
      } else {
        lastErrorMessage = 'Logout failed.';
        emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      emit(AuthError(lastErrorMessage!));
    }
  }

  Map<String, dynamic> registrydata = {};

  void cookregistryfisrt({
    required String guard,
    required String labName,
    required String fullName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required List<String> labPhone,
    required String province,
    required String address,
  }) {
    emit(AuthLoading());
    registrydata.addAll({
      'guard': guard,
      'full_name': fullName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'lab_name': labName,
      'lab_phone': labPhone,
      'lab_province': province,
      'lab_address': address,
    });
    print('first cook: ' + registrydata.toString());
    emit(AuthInitial());
  }

  void cookregistrysecond({
    required String labType,
    required String startHour,
    required String endHour,
    required int subscriptionDuration,
  }) {
    emit(AuthLoading());
    registrydata.addAll({
      'lab_type': labType,
      'work_from_hour': startHour,
      'work_to_hour': endHour,
      'register_subscription_duration': subscriptionDuration,
    });
    emit(AuthInitial());
    print(registrydata);
    register();
  }

  Future<void> register() async {
    emit(AuthLoading());
    try {
      success = await repo.postregister(registrydata);
      if (success) {
        emit(AuthRegistered());
        registrydata.clear();
      } else {
        lastErrorMessage = 'Registration failed.';
        emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      emit(AuthError(lastErrorMessage!));
    }
  }

  LabProfile? profile;

  Future<void> getProfile() async {
    emit(AuthLoading());
    try {
      profile = await repo.getProfile();
      if (profile != null) {
        emit(AuthProfileLoaded(profile!));
      } else {
        lastErrorMessage = 'No profile found.';
        emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      emit(AuthError(lastErrorMessage!));
    }
  }
}
