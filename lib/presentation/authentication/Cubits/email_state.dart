abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailChecking extends EmailState {}

class EmailChecked extends EmailState {}

class EmailError extends EmailState {
  final String message;
  EmailError(this.message);
}
