import 'package:lambda_dent_dash/domain/models/auth/profile/lab_profile.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthRegistered extends AuthState {}

class AuthProfileLoaded extends AuthState {
  final LabProfile profile;
  AuthProfileLoaded(this.profile);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
