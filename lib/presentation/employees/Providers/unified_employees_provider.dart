import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_employees_repo.dart';
import 'package:lambda_dent_dash/presentation/employees/Cubits/employees_cubit.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';

class UnifiedEmployeesProvider extends StatelessWidget {
  final Widget child;

  const UnifiedEmployeesProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DBEmployeesRepo>(
          create: (context) => locator<DBEmployeesRepo>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeesCubit>(
            create: (context) => EmployeesCubit(
              context.read<DBEmployeesRepo>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
