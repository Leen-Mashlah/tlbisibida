import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
// import 'package:power_overload/Shared/constants.dart';

Widget defaultTextField(
    TextEditingController controller, BuildContext context, String label,
    {Icon? prefixIcon,
    int height = 1,
    int maxLines = 1,
    Widget? postfixicon,
    bool obscureText = false,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    Color inactiveColor = Colors.grey,
    Color activeColor = cyan300,
    bool autofocus = false}) {
  return TextFormField(
    autofocus: autofocus,
    minLines: height,
    maxLines: maxLines,
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(
      label: Text(label),
      prefixIcon: prefixIcon,
      suffixIcon: postfixicon,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: inactiveColor, width: 1.0),
          borderRadius: standardBorderRadius),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: activeColor, width: 1.5),
        borderRadius: standardBorderRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: redmain, width: 2.0),
        borderRadius: activeBorderRadius,
      ),
    ),
  );
}
