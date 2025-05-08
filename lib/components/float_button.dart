import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
// import 'package:power_overload/Shared/constants.dart';

Widget floatButton(
    {VoidCallback? onTap,
    // ValueChanged<bool>? hoverfunction,
    IconData? icon,
    Color? color}) {
  return InkWell(
    onTap: onTap,
    // onHover: hoverfunction,
    borderRadius: BorderRadius.circular(15),
    child: Container(
      width: 52.0,
      height: 52.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color ?? cyan200,
      ),
      child: Icon(
        icon,
        color: cyan400,
        size: 25.0,
      ),
    ),
  );
}
