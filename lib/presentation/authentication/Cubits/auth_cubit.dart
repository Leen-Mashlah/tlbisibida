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
    if (isClosed) return;
    emit(AuthLoading());
    try {
      success = await repo.postlogin(email, password, guard);
      if (success) {
        if (isClosed) return;
        emit(AuthLoggedIn());
      } else {
        lastErrorMessage = 'Login failed. Please check your credentials.';
        if (!isClosed) emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      if (!isClosed) emit(AuthError(lastErrorMessage!));
    }
  }

  Future<void> logout() async {
    if (isClosed) return;
    emit(AuthLoading());
    try {
      success = await repo.postlogout();
      if (success) {
        if (isClosed) return;
        emit(AuthLoggedOut());
      } else {
        lastErrorMessage = 'Logout failed.';
        if (!isClosed) emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      if (!isClosed) emit(AuthError(lastErrorMessage!));
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
    if (isClosed) return;
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
    if (!isClosed) emit(AuthInitial());
  }

  void cookregistrysecond({
    required String labType,
    required String startHour,
    required String endHour,
    required int subscriptionDuration,
  }) {
    if (isClosed) return;
    emit(AuthLoading());
    registrydata.addAll({
      'lab_type': labType,
      'work_from_hour': startHour,
      'work_to_hour': endHour,
      'register_subscription_duration': subscriptionDuration,
    });
    if (!isClosed) emit(AuthInitial());
    print(registrydata);
    register();
  }

  Future<void> register() async {
    if (isClosed) return;
    emit(AuthLoading());
    try {
      success = await repo.postregister(registrydata);
      if (success) {
        if (isClosed) return;
        emit(AuthRegistered());
        registrydata.clear();
      } else {
        lastErrorMessage = 'Registration failed.';
        if (!isClosed) emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      if (!isClosed) emit(AuthError(lastErrorMessage!));
    }
  }

  LabProfile? profile;

  Future<void> getProfile() async {
    if (isClosed) return;
    emit(AuthLoading());
    try {
      profile = await repo.getProfile();
      if (profile != null) {
        if (isClosed) return;
        emit(AuthProfileLoaded(profile!));
      } else {
        lastErrorMessage = 'No profile found.';
        if (!isClosed) emit(AuthError(lastErrorMessage!));
      }
    } catch (e) {
      lastErrorMessage = e.toString();
      if (!isClosed) emit(AuthError(lastErrorMessage!));
    }
  }
}

