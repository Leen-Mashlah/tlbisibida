import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/router.dart';
import 'package:lambda_dent_dash/constant/components/site_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  setupLocator();
  
  // Initialize navigation service after setup
  final navigationService = locator<NavigationService>();
  runApp(const MyApp());
  
  // Set initial title after app starts
  WidgetsBinding.instance.addPostFrameCallback((_) {
    navigationService.init();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Remove initialRoute to prevent double initialization
      onGenerateRoute: (settings) => generateRoute(settings),
      title: 'LambdaDent Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
        primaryColor: cyan300,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: cyan50,
      ),
      home: SiteLayout(), // Set home directly
    );
  }
}
