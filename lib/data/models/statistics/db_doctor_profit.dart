import 'package:lambda_dent_dash/domain/models/statistics/doctor_profit.dart';

class DBDoctorProfit {
  final String fullName;
  final int dentistId;
  final double totalSignedValue;

  DBDoctorProfit({
    required this.fullName,
    required this.dentistId,
    required this.totalSignedValue,
  });

  factory DBDoctorProfit.fromJson(Map<String, dynamic> json) => DBDoctorProfit(
        fullName: json['fullname']?.toString() ?? '',
        dentistId: json['dentist_id'] ?? 0,
        totalSignedValue: _toDouble(json['total_signed_value']),
      );

  DoctorProfit toDomain() => DoctorProfit(
      fullName: fullName,
      dentistId: dentistId,
      totalSignedValue: totalSignedValue);
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0.0;
}
