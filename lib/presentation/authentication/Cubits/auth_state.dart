import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthRegistered extends AuthState {
  final String message;
  AuthRegistered(this.message);
}

class AuthRegisterCooking extends AuthState {}

class AuthProfileLoaded extends AuthState {
  final LabProfile profile;
  AuthProfileLoaded(this.profile);
}

class AuthPasswordVisibilityChanged extends AuthState {}

class AuthRememberMeStatusChanged extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
