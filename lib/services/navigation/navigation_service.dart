import 'package:flutter/cupertino.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

// class NavigationService {
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   Future<dynamic> navigateTo(String routeName) {
//     return navigatorKey.currentState!.pushNamed(routeName);
//   }

//   void goBack() {
//     return navigatorKey.currentState!.pop();
//   }
// }
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final ValueNotifier<String> currentTitle = ValueNotifier(homePageDisplayName);
  final ValueNotifier<bool> showBackButton = ValueNotifier(false);
  // Add this method
  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateNavigationState();
    });
  }

  Future<dynamic> navigateTo(String routeName) {
    final title = _getTitleForRoute(routeName);
    currentTitle.value = title;
    showBackButton.value = true;
    if (routeName == homePageRoute) {
      navigatorKey.currentState!.popUntil(ModalRoute.withName('/'));
      return navigatorKey.currentState!.pushNamed(routeName).then((_) {
        updateNavigationState();
      });
    }

    return navigatorKey.currentState!.pushNamed(routeName).then((_) {
      updateNavigationState();
    });
  }

  void goBack() {
    navigatorKey.currentState!.pop();
    updateNavigationState();
  }

  void updateNavigationState() {
    final currentContext = navigatorKey.currentContext;
    if (currentContext == null) return;

    final currentRoute = ModalRoute.of(currentContext);
    if (currentRoute != null) {
      final routeName = currentRoute.settings.name;
      if (routeName != null && routeName.isNotEmpty && routeName != '/') {
        currentTitle.value = routeName;
      } else {
        currentTitle.value = homePageDisplayName;
      }
    }
    showBackButton.value = navigatorKey.currentState?.canPop() ?? false;
  }

  String _getTitleForRoute(String routeName) {
    switch (routeName) {
      case authenticationPageRoute:
        return authenticationPageDisplayName;
      case homePageRoute:
        return homePageDisplayName;
      case billsPageRoute:
        return billsPageDisplayName;
      case clientPageRoute:
        return clientPageDisplayName;
      case clientDetailsPageRoute:
        return clientDetailsPageDisplayName;
      case casesPageRoute:
        return casesPageDisplayName;
      case inventoryPageRoute:
        return inventoryPageDisplayName;
      case paymentsLogPageRoute:
        return paymentsLogPageDisplayName;
      case statisticsPageRoute:
        return statisticsPageDisplayName;
      // Add all your other routes here
      default:
        return homePageDisplayName;
    }
  }
}
