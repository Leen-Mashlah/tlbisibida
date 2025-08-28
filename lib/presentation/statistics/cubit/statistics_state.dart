abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> operatingPayments;
  final List<Map<String, dynamic>> doctorProfits;
  final List<Map<String, dynamic>> itemMonthly; // last loaded item series
  final List<Map<String, dynamic>> itemsList; // id+name for dropdown
  StatisticsLoaded({
    required this.categories,
    required this.operatingPayments,
    required this.doctorProfits,
    required this.itemMonthly,
    required this.itemsList,
  });
}

class StatisticsError extends StatisticsState {
  final String message;
  StatisticsError(this.message);
}
