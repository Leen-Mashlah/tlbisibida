import 'package:get_it/get_it.dart';
import 'package:lambda_dent_dash/data/repo/db_auth_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_bills_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_cases_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_clients_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_email_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_employees_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_statistics_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_payments_repo.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DBAuthRepo());
  locator.registerLazySingleton(() => DBEmailRepo());
  locator.registerLazySingleton(() => DBCasesRepo());
  locator.registerLazySingleton(() => DBClientsRepo());
  locator.registerLazySingleton(() => DBBillsRepo());
  locator.registerLazySingleton(() => DBEmployeesRepo());
  locator.registerLazySingleton(() => DBStatisticsRepo());
  locator.registerLazySingleton(() => DBPaymentsRepo());

  // locator.registerLazySingleton(() => StackObserver());
}
