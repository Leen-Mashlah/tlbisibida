import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/reponsiveness.dart';
import 'package:lambda_dent_dash/components/top_nav.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/router.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: false,
      appBar: TopNavigationBar(),
      body: ResponsiveWidget(
        largeScreen: Navigator(
          key: locator<NavigationService>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: rootRoute, // Change to rootRoute
        ),
      ),
    );
  }
}
