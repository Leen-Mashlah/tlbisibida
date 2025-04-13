import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

AppBar topNavigationBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 1,
    leading: Image.asset(
      'assets/logo_v2.png',
      width: 24,
      height: 24,
    ),
    title: const Text('Page Title'),
    centerTitle: true,
    iconTheme: const IconThemeData(color: cyan500),
    elevation: 0,
    backgroundColor: cyan100,
    actions: [
      IconButton(
        onPressed: () {
          locator<NavigationService>().navigateTo(homePageRoute);
        },
        icon: const Icon(
          Icons.home_rounded,
        ),
      ),
      IconButton(
        onPressed: () {
          //Show Settings
        },
        icon: const Icon(
          Icons.settings,
        ),
      ),
      IconButton(
        onPressed: () {
          locator<NavigationService>().navigateTo(clientPageRoute);
        },
        icon: const Icon(
          Icons.person,
        ),
      ),
      IconButton(
        onPressed: () {
          // Navigate to about screen
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
        },
        icon: const Icon(
          Icons.notifications_none_rounded,
        ),
      ),
    ],
  );
}
