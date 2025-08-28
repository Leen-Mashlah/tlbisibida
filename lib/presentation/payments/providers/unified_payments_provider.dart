import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_payments_repo.dart';
import 'package:lambda_dent_dash/presentation/payments/cubit/payments_cubit.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';

class UnifiedPaymentsProvider extends StatelessWidget {
  final Widget child;
  const UnifiedPaymentsProvider({super.key, required this.child});

  DBPaymentsRepo get repo => locator<DBPaymentsRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentsCubit(repo)..loadLabItemsHistory(),
      child: child,
    );
  }
}
