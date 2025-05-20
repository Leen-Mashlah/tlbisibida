import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:pie_menu/pie_menu.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavigationBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return ValueListenableBuilder(
      valueListenable: navigationService.currentTitle,
      builder: (context, title, _) {
        return ValueListenableBuilder(
          valueListenable: navigationService.showBackButton,
          builder: (context, showBack, _) {
            return AppBar(
              foregroundColor: cyan_navbar_600,
              scrolledUnderElevation: 1,
              leading: showBack
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => navigationService.goBack(),
                      color: cyan500,
                    )
                  : const SizedBox(),
              title: Text(
                title,
                style: const TextStyle(color: cyan500),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: cyan500),
              elevation: 0,
              backgroundColor: cyan100,
              actions: [
                IconButton(
                  onPressed: () => navigationService.navigateTo(homePageRoute),
                  icon: const Icon(Icons.home_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 10),
                  child: PieMenu(
                      theme: const PieTheme(
                          tooltipCanvasAlignment: Alignment.centerRight,
                          buttonThemeHovered: PieButtonTheme(
                              backgroundColor: cyan300, iconColor: cyan600),
                          pointerColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          delayDuration: Duration.zero,
                          customAngle: 247 + 70,
                          angleOffset: 10,
                          spacing: 3,
                          radius: 120,
                          buttonSize: 38,
                          buttonTheme: PieButtonTheme(
                              iconColor: cyan_navbar_600,
                              backgroundColor: cyan200)),
                      actions: [
                        PieAction(
                            tooltip: const SizedBox(),
                            onSelect: () {
                              navigationService.navigateTo(employeesPageRoute);
                            },
                            child: const Icon(CupertinoIcons
                                .rectangle_stack_person_crop_fill)),
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
                      child: const Icon(CupertinoIcons.circle_grid_hex_fill)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
