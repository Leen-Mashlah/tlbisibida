import 'package:lambda_dent_dash/services/BloC/Cubits/teeth_cubit.dart';

abstract class TeethState {
  const TeethState();
}

class TeethInitial extends TeethState {}

class TeethLoading extends TeethState {}

class TeethLoaded extends TeethState {
  final Data data;
  const TeethLoaded(this.data);
}

class TeethError extends TeethState {
  final String message;
  const TeethError(this.message);
}
