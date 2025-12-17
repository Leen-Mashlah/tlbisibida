import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,
    {required String message, required AnimatedSnackBarType type}) {
  AnimatedSnackBar.material(
    message,
    type: type,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    desktopSnackBarPosition: DesktopSnackBarPosition.bottomRight,
    duration: Duration(seconds: 3),
    animationCurve: Easing.standard,
  ).show(context);
}
