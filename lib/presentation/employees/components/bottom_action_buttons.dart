import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/employees/components/Dialogs/employee_delete_dialog.dart';
import 'package:lambda_dent_dash/presentation/employees/components/Dialogs/employee_edit_dialog.dart';


Row bottomActionButtons(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return employeeDeleteConfirmationDialog(context);
                });
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: redbackground,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5))),
            child: const Icon(Icons.delete_outline_rounded, color: redmain),
          ),
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return employeeEditDialog(context);
              },
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: cyan200,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5))),
            child: const Icon(
              Icons.edit_rounded,
              color: cyan400,
            ),
          ),
        ),
      ),
    ],
  );
}
