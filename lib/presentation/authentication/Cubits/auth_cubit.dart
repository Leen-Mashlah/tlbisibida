import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/repo/auth_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';

class AuthCubit extends Cubit<String> {
  AuthCubit(this.repo) : super('');
  final AuthRepo repo;

  bool success = false;

  Future<void> login(String email, String password, String guard) async {
    emit('logging_in');
    try {
      success = await repo.postlogin(email, password, guard);
    } on Exception catch (e) {
      emit('error');
      print(e.toString());
    }
    success ? emit('logged_in') : emit('error');
    print(state);
  }

  Future<void> logout() async {
    emit('logging_out');
    try {
      success = await repo.postlogout();
    } on Exception catch (e) {
      emit('error');
      print(e);
    }
    success ? emit('logged_out') : emit('error');
    print(state);
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
    // required Map<String, String> workingHours,
  }) {
    emit('cooking');
    registrydata = {
      'guard': guard,
      'full_name': fullName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'lab_name': labName,
      'lab_phone': labPhone,
      'lab_province': province,
      'lab_address': address,
    };
    emit('cooked');
  }

  void cookregistrysecond({
    required String labType,
    required String startHour,
    required String endHour,
    required int subscriptionDuration,
  }) {
    emit('cooking');
    registrydata.addAll({
      'lab_type': labType,
      'work_from_hour': startHour,
      'work_to_hour': endHour,
      'register_subscription_duration': subscriptionDuration,
    });
    emit('cooked');
    register();
  }

  //Register
  Future<void> register() async {
    emit('registering');
    try {
      success = await repo.postregister(registrydata);
    } on Exception catch (e) {
      emit('error');
      print(e.toString());
    }
    success ? emit('registered') : emit('error');
    CacheHelper.setString('email', registrydata['email']);
    print(state);
  }
}
