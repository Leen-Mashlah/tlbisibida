import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class NinjaStarShape extends StatelessWidget {
  const NinjaStarShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                blade('الحالات', casesPageRoute),
                Transform.rotate(
                    angle: 180 * pi / 180,
                    child: blade("الفواتير", billsPageRoute)),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                    angle: -90 * pi / 180,
                    child: blade("المدفوعات", paymentsLogPageRoute)),
                Transform.rotate(
                    angle: 90 * pi / 180,
                    child: blade("المخزن", inventoryPageRoute)),
              ],
            ),
          ),
          const Center(
            child: Icon(
              Icons.circle,
              size: 50,
              color: Colors.white,
            ),
          ),
          Center(
            child: Icon(
              Icons.circle_outlined,
              size: 50,
              color: Colors.grey[500],
            ),
          ),
        ],
      ).animate().rotate(duration: const Duration(minutes: 60), begin: -20),
    );
  }

  Widget blade(String data, String route) {
    return ClipPath(
      clipper: _Triangle(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          locator<NavigationService>().navigateTo(route);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(color: Colors.grey[400]!, width: 2)),
                  gradient: const LinearGradient(
                      colors: [cyan200, cyan300, cyan400])),
              width: 320,
              height: 320,
            ),
            Positioned(
                bottom: 90,
                left: 40,
                child: Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Text(
                      data,
                      style: TextStyle(color: Colors.grey[600], fontSize: 18),
                    )))
          ],
        ),
      ),
    );
  }
}

class _Triangle extends CustomClipper<Path> {
  // _Triangle(int x,int y){}
  @override
  Path getClip(Size size) {
    final Path path = Path();
    //0,0
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(0, 0);
    // path.lineTo(size.width/2, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    //   path.lineTo(size.width / 2, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
