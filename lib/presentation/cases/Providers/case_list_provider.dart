import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_cases_repo.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';
import 'package:lambda_dent_dash/presentation/cases/Views/cases_list_page.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';

class CaseListProvider extends StatelessWidget {
  CaseListProvider({super.key});
  final DBCasesRepo casesRepo = locator<DBCasesRepo>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CasesCubit(casesRepo),
      child: const CasesListPage(),
    );
  }
}
