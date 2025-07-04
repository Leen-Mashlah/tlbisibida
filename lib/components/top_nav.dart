import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/my_pie_menu.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavigationBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();

    return ValueListenableBuilder(
      valueListenable: navigationService.currentTitle,
      builder: (context, title, _) => ValueListenableBuilder(
          valueListenable: navigationService.showBackButton,
          builder: (context, showBack, _) => AppBar(
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
                  child: myPieMenu(navigationService),
                ),
              ],
            ),
        ),
    );
  }
}
