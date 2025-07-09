import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/presentation/authentication/Providers/email_provider.dart';
import 'package:lambda_dent_dash/presentation/cases/Providers/case_list_provider.dart';
import 'package:lambda_dent_dash/presentation/profile/profile_provider.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/authentication.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/choose_role_page.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/register.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/register_2.dart';
import 'package:lambda_dent_dash/presentation/bills/bills_page.dart';
import 'package:lambda_dent_dash/presentation/cases/Views/add_case_page.dart';
import 'package:lambda_dent_dash/presentation/cases/Views/case_details_page.dart';
import 'package:lambda_dent_dash/presentation/clients/client_details_page.dart';
import 'package:lambda_dent_dash/presentation/clients/clients_page.dart';
import 'package:lambda_dent_dash/presentation/employees/emplyoees_page.dart';
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
      return _getPageRoute(AuthenticationPage(), authenticationPageDisplayName);

    case registerPageRoute:
      return _getPageRoute(RegisterPage(), registerPageDisplayName);

    case register2PageRoute:
      return _getPageRoute(Register2Page(), register2PageDisplayName);

    case rolePageRoute:
      return _getPageRoute(const ChooseRolePage(), rolePageDisplayName);

    //Home
    case homePageRoute:
      return _getPageRoute(const HomePage(), homePageDisplayName);

    //Bills
    case billsPageRoute:
      return _getPageRoute(BillsPage(), billsPageDisplayName);

    //Cases
    case casesPageRoute:
      return _getPageRoute(CaseListProvider(), casesPageDisplayName);

    case caseDetailsPageRoute:
      return _getPageRoute(CaseDetails(), caseDetailsPageDisplayName);

    case addCasePageRoute:
      return _getPageRoute(AddCasePage(), addCasePageDisplayName);

    //Clients
    case clientPageRoute:
      return _getPageRoute(ClientsPage(), clientPageDisplayName);
    case clientDetailsPageRoute:
      return _getPageRoute(ClientDetailsPage(), clientDetailsPageDisplayName);

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
      return _getPageRoute(ProfileProvider(), profilePageDisplayName);

    //Statistics Page
    case statisticsPageRoute:
      return _getPageRoute(StatisticsPage(), statisticsPageDisplayName);

    //Settings Page
    case settingsPageRoute:
      return _getPageRoute(const Settings(), settingsPageDisplayName);

    case emailVerificationPageRoute:
      return _getPageRoute(
          EmailVerifyProvider(), emailVerificationDisplayName);

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
