import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/presentation/authentication/Providers/email_provider.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/choose_role_page.dart';
import 'package:lambda_dent_dash/presentation/authentication/Providers/unified_auth_provider.dart';
import 'package:lambda_dent_dash/presentation/cases/Providers/unified_cases_provider.dart';
import 'package:lambda_dent_dash/presentation/clients/Providers/unified_clients_provider.dart';
import 'package:lambda_dent_dash/presentation/bills/Providers/unified_bills_clients_provider.dart';
import 'package:lambda_dent_dash/presentation/cases/Views/add_case_page.dart';
import 'package:lambda_dent_dash/presentation/employees/employees_page.dart';
import 'package:lambda_dent_dash/presentation/home/home_page.dart';
import 'package:lambda_dent_dash/presentation/inventory/inventory_page.dart';
import 'package:lambda_dent_dash/presentation/payments/payments_log_page.dart';
import 'package:lambda_dent_dash/presentation/settings/settings.dart';
import 'package:lambda_dent_dash/presentation/statistics/statistics_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');

  switch (settings.name) {
    //Auth
    case authenticationPageRoute:
      return _getPageRoute(
          const UnifiedAuthProvider(pageType: AuthPageType.authentication),
          authenticationPageDisplayName);

    case registerPageRoute:
      return _getPageRoute(
          const UnifiedAuthProvider(pageType: AuthPageType.register),
          registerPageDisplayName);

    case register2PageRoute:
      return _getPageRoute(
          const UnifiedAuthProvider(pageType: AuthPageType.register2),
          register2PageDisplayName);

    case rolePageRoute:
      return _getPageRoute(const ChooseRolePage(), rolePageDisplayName);

    //Home
    case homePageRoute:
      return _getPageRoute(const HomePage(), homePageDisplayName);

    //Bills
    case billsPageRoute:
      return _getPageRoute(
          const UnifiedBillsClientsProvider(
              pageType: BillsClientsPageType.bills),
          billsPageDisplayName);

    //Cases
    case casesPageRoute:
      return _getPageRoute(
          const UnifiedCasesProvider(pageType: CasesPageType.casesList),
          casesPageDisplayName);

    case caseDetailsPageRoute:
      return _getPageRoute(
          const UnifiedCasesProvider(pageType: CasesPageType.caseDetails),
          caseDetailsPageDisplayName);

    case addCasePageRoute:
      return _getPageRoute(AddCasePage(), addCasePageDisplayName);

    //Clients
    case clientPageRoute:
      return _getPageRoute(
          const UnifiedClientsProvider(pageType: ClientsPageType.clientsList),
          clientPageDisplayName);
    case clientDetailsPageRoute:
      return _getPageRoute(
          const UnifiedClientsProvider(pageType: ClientsPageType.clientDetails),
          clientDetailsPageDisplayName);

    //Employees
    case employeesPageRoute:
      return _getPageRoute(EmplyoeesPage(), employeesPageDisplayName);

    //Inventory
    case inventoryPageRoute:
      return _getPageRoute(InventoryPage(), inventoryPageDisplayName);

    //Payments
    case paymentsLogPageRoute:
      return _getPageRoute(PaymentsLogPage(), paymentsLogPageDisplayName);

    //User Profile
    case profilePageRoute:
      return _getPageRoute(
          const UnifiedAuthProvider(pageType: AuthPageType.profile),
          profilePageDisplayName);

    //Statistics Page
    case statisticsPageRoute:
      return _getPageRoute(StatisticsPage(), statisticsPageDisplayName);

    //Settings Page
    case settingsPageRoute:
      return _getPageRoute(const Settings(), settingsPageDisplayName);

    case emailVerificationPageRoute:
      return _getPageRoute(EmailVerifyProvider(), emailVerificationDisplayName);

    default:
      return _getPageRoute(const HomePage(), homePageDisplayName);
  }
}

PageRoute _getPageRoute(Widget child, String title) {
  locator<NavigationService>().currentTitle.value = title;
  return MaterialPageRoute(
    builder: (context) => child,
    settings: RouteSettings(name: title),
  );
}
