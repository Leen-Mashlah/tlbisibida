import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_statistics_repo.dart';
import 'package:lambda_dent_dash/presentation/statistics/cubit/statistics_cubit.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';

class UnifiedStatisticsProvider extends StatelessWidget {
  final Widget child;
  const UnifiedStatisticsProvider({super.key, required this.child});

  DBStatisticsRepo get statsRepo => locator<DBStatisticsRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StatisticsCubit(statsRepo)..loadAll(),
      child: child,
    );
  }
}
