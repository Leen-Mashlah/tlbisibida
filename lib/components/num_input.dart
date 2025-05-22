import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Widget NumInput(BuildContext context,
    {autofocus = false, TextEditingController? controller}) {
  return SizedBox(
    width: 35,
    height: 70,
    child: TextFormField(
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, color: cyan50),
      cursorColor: cyan50,
      maxLength: 1,
      maxLines: 1,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        counterText: '',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cyan600, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cyan50, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: redmain, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (value) {
        nextFocus(context);
      },
    ),
  );
}

void nextFocus(BuildContext context) {
  FocusScope.of(context).nextFocus();
}
