import 'package:get_it/get_it.dart';
import 'package:lambda_dent_dash/data/repo/auth_repo.dart';
import 'package:lambda_dent_dash/data/repo/email_repo.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(()=> DBAuthRepo());
  locator.registerLazySingleton(()=> DBEmailRepo());
  // locator.registerLazySingleton(() => StackObserver());
}
