import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/view/authentication/authentication.dart';
import 'package:lambda_dent_dash/view/bills/bills_page.dart';
import 'package:lambda_dent_dash/view/cases/case_details_page.dart';
import 'package:lambda_dent_dash/view/cases/cases_list_page.dart';
import 'package:lambda_dent_dash/view/clients/client_details_page.dart';
import 'package:lambda_dent_dash/view/clients/clients_page.dart';
import 'package:lambda_dent_dash/view/employees/emplyoees_page.dart';
import 'package:lambda_dent_dash/view/home/home_page.dart';
import 'package:lambda_dent_dash/view/inventory/inventory_page.dart';
import 'package:lambda_dent_dash/view/payments/payments_log_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');

  switch (settings.name) {
    //Auth
    case authenticationPageRoute:
      return _getPageRoute(AuthenticationPage());

    //Home
    case homePageRoute:
      return _getPageRoute(const HomePage());

    //Bills
    case billsPageRoute:
      return _getPageRoute(BillsPage());

    //Cases
    case casesPageRoute:
      return _getPageRoute(const CasesListPage());
    case caseDetailsPageRoute:
      return _getPageRoute(CaseDetails());

    //Clients
    case clientPageRoute:
      return _getPageRoute(ClientsPage());
    case clientDetailsPageRoute:
      return _getPageRoute(ClientDetailsPage());

    //Employees
    case employeesPageRoute:
      return _getPageRoute(EmplyoeesPage());

    //Inventory
    case inventoryPageRoute:
      return _getPageRoute(InventoryPage());

    //Payments
    case paymentsLogPageRoute:
      return _getPageRoute(PaymentsLogPage());

    //TODO: Statistics Page
    // case statisticsPageRoute:
    // return _getPageRoute(StatisticsPage());

    default:
      return _getPageRoute(const HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
