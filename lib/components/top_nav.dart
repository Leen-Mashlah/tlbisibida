import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
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
              scrolledUnderElevation: 1,
              leading: showBack
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => navigationService.goBack(),
                      color: cyan500,
                    )
                  : SizedBox(),
              title: Text(title),
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
                  onPressed: () =>
                      navigationService.navigateTo(profilePageRoute),
                  icon: const Icon(Icons.person),
                ),
                IconButton(
                  onPressed: () =>
                      navigationService.navigateTo(clientPageRoute),
                  icon: const Icon(Icons.people),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
