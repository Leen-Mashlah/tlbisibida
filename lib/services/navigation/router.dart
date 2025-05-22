import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/view/authentication/authentication.dart';
import 'package:lambda_dent_dash/view/authentication/choose_rool_page.dart';
import 'package:lambda_dent_dash/view/authentication/register.dart';
import 'package:lambda_dent_dash/view/authentication/register_2.dart';
import 'package:lambda_dent_dash/view/bills/bills_page.dart';
import 'package:lambda_dent_dash/view/cases/pages/case_details_page.dart';
import 'package:lambda_dent_dash/view/cases/pages/cases_list_page.dart';
import 'package:lambda_dent_dash/view/clients/client_details_page.dart';
import 'package:lambda_dent_dash/view/clients/clients_page.dart';
import 'package:lambda_dent_dash/view/employees/emplyoees_page.dart';
import 'package:lambda_dent_dash/view/home/home_page.dart';
import 'package:lambda_dent_dash/view/inventory/inventory_page.dart';
import 'package:lambda_dent_dash/view/payments/payments_log_page.dart';
import 'package:lambda_dent_dash/view/profile/profile_page.dart';
import 'package:lambda_dent_dash/view/settings/settings.dart';
import 'package:lambda_dent_dash/view/statistics/statistics_page.dart';

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
      return _getPageRoute(const CasesListPage(), casesPageDisplayName);

    case caseDetailsPageRoute:
      return _getPageRoute(CaseDetails(), caseDetailsPageDisplayName);

    case addCasePageRoute:
      return _getPageRoute(CaseDetails(), addCasePageDisplayName);

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
      return _getPageRoute(ProfilePage(), profilePageDisplayName);

    //Statistics Page
    case statisticsPageRoute:
      return _getPageRoute(StatisticsPage(), statisticsPageDisplayName);

    //Settings Page
    case settingsPageRoute:
      return _getPageRoute(const Settings(), settingsPageDisplayName);

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
