import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_cases_repo.dart';
import 'package:lambda_dent_dash/presentation/cases/Views/add_case_page.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';
import 'package:lambda_dent_dash/presentation/cases/Views/cases_list_page.dart';
import 'package:lambda_dent_dash/presentation/cases/Views/case_details_page.dart';

enum CasesPageType {
  casesList,
  caseDetails,
  addCase
}

class UnifiedCasesProvider extends StatelessWidget {
  final CasesPageType pageType;

  const UnifiedCasesProvider({
    super.key,
    required this.pageType,
  });

  DBCasesRepo get casesRepo => locator<DBCasesRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CasesCubit(casesRepo);
        if (pageType == CasesPageType.caseDetails) {
          final int? caseId =
              ModalRoute.of(context)?.settings.arguments as int?;
          if (caseId != null) {
            cubit.getCaseDetails(caseId);
          }
        }
        return cubit;
      },
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    switch (pageType) {
      case CasesPageType.casesList:
        return const CasesListPage();
      case CasesPageType.caseDetails:
        return CaseDetails();
      case CasesPageType.addCase:
        return  AddCasePage();
    }
  }
}
