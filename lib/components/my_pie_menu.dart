import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

Widget myPieMenu(NavigationService navigationService) {
  return PieMenu(
      theme: const PieTheme(
          tooltipCanvasAlignment: Alignment.centerRight,
          buttonThemeHovered:
              PieButtonTheme(backgroundColor: cyan300, iconColor: cyan600),
          pointerColor: Colors.transparent,
          overlayColor: Colors.transparent,
          delayDuration: Duration.zero,
          customAngle: 247 + 70,
          angleOffset: 10,
          spacing: 3,
          radius: 120,
          buttonSize: 38,
          buttonTheme: PieButtonTheme(
              iconColor: cyan_navbar_600, backgroundColor: cyan200)),
      actions: [
        PieAction(
            tooltip: const SizedBox(),
            onSelect: () {
              navigationService.navigateTo(employeesPageRoute);
            },
            child: const Icon(CupertinoIcons.rectangle_stack_person_crop_fill)),
        PieAction(
          tooltip: const SizedBox(),
          onSelect: () {
            navigationService.navigateTo(profilePageRoute);
          },
          child: const Icon(Icons.person),
        ),
        PieAction(
          tooltip: const SizedBox(),
          onSelect: () {
            navigationService.navigateTo(statisticsPageRoute);
          },
          child: const Icon(CupertinoIcons.chart_pie_fill),
        ),
        PieAction(
          tooltip: const SizedBox(),
          onSelect: () {
            navigationService.navigateTo(clientPageRoute);
          },
          child: const Icon(Icons.people),
        ),
      ],
      child: const Icon(CupertinoIcons.circle_grid_hex_fill));
}
