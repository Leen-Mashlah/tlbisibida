import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
// import 'package:power_overload/Shared/constants.dart';

Widget datePicker(BuildContext context, DateTime birthdate) {
  DateTime dateTime = DateTime.now();
  void getDatePicker() {
    showDatePicker(
      //barrierColor: green400,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      value != null ? dateTime = value : dateTime = DateTime.now();
    });
  }

  return SizedBox(
    width: 200,
    child: Card(
      clipBehavior: Clip.antiAlias,
      color: cyan100,
      elevation: 1,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: cyan400, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: getDatePicker,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                style: const TextStyle(fontSize: 20),
              ),
              const Icon(Icons.calendar_month_outlined),
            ],
          ),
        ),
      ),
    ),
  );
}
