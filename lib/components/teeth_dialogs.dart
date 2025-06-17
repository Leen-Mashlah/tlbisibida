import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/services/BloC/Cubits/teeth_cubit.dart';

void showAlertDialogDoc(BuildContext context, Tooth tooth, TeethCubit cubit) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: Text(
        'اختر العلاج:',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: cyan400, fontSize: 18),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'حشوة ضوئية');
            cubit.toggleToothSelection(tooth); // Select after material is set
          },
          child: const Text('حشوة ضوئية'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'تحضير تاج/فينير');
            (context, tooth, cubit);
            cubit.toggleToothSelection(tooth); // Select after material is set
          },
          child: const Text('تحضير تاج/فينير'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'قلع');
            (context, tooth, cubit);
            cubit.toggleToothSelection(tooth); // Select after material is set
          },
          child: const Text('قلع'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'سحب عصب');
            (context, tooth, cubit);
            cubit.toggleToothSelection(tooth); // Select after material is set
          },
          child: const Text('سحب عصب'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'زرع');
            (context, tooth, cubit);
            cubit.toggleToothSelection(tooth); // Select after material is set
          },
          child: const Text('زرع'),
        ),
        // CupertinoDialogAction(
        //   isDefaultAction: true,
        //   onPressed: () {
        //     Navigator.pop(context);
        //     cubit.setToothTreatment(tooth, 'بدلة');
        //     (context, tooth, cubit);
        //   },
        //   child: const Text('بدلة'),
        // ),
      ],
    ),
  );
}

void showAlertDialog(BuildContext context, Tooth tooth, TeethCubit cubit) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: Text(
        'اختر العلاج:',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: cyan400, fontSize: 18),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'تاج');
            showAlertDialog2(context, tooth, cubit);
          },
          child: const Text('تاج'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'دمية');
            (context, tooth, cubit);
            showAlertDialog2(context, tooth, cubit);
          },
          child: const Text('دمية'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'زرعة');
            (context, tooth, cubit);
            showAlertDialog2(context, tooth, cubit);
          },
          child: const Text('زرعة'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'فينير');
            (context, tooth, cubit);
            showAlertDialog2(context, tooth, cubit);
          },
          child: const Text('فينير'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'حشوة');
            (context, tooth, cubit);
            showAlertDialog2(context, tooth, cubit);
          },
          child: const Text('حشوة'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.setToothTreatment(tooth, 'بدلة');
            (context, tooth, cubit);
            showAlertDialog2(context, tooth, cubit);
          },
          child: const Text('بدلة'),
        ),
      ],
    ),
  );
}

void showAlertDialog2(BuildContext context, Tooth tooth, TeethCubit cubit) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: Text(
        'اختر المادة العلاجية:',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: cyan400, fontSize: 18),
      ),
      actions: <CupertinoDialogAction>[
        if (tooth.treatment != 'بدلة')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'زيركون');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('زيركون'),
          ),
        if (tooth.treatment != 'بدلة' &&
            tooth.treatment != 'حشوة' &&
            tooth.treatment != 'فينير')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'خزف على معدن');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('خزف على معدن'),
          ),
        if (tooth.treatment != 'بدلة' &&
            tooth.treatment != 'حشوة' &&
            tooth.treatment != 'فينير')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'شمع');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('شمع'),
          ),
        if (tooth.treatment != 'بدلة' &&
            tooth.treatment != 'حشوة' &&
            tooth.treatment != 'فينير')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'أكريل مؤقت');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('أكريل مؤقت'),
          ),
        if (tooth.treatment == 'حشوة' || tooth.treatment == 'فينير')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'EMax');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('EMax'),
          ),
        if (tooth.treatment == 'بدلة')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'أكريل');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('أكريل'),
          ),
        if (tooth.treatment == 'بدلة')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'أكريل مبطن');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('أكريل مبطن'),
          ),
        if (tooth.treatment == 'بدلة')
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              cubit.setToothMaterial(tooth, 'فليكس');
              cubit.toggleToothSelection(tooth); // Select after material is set
            },
            child: const Text('فليكس'),
          ),
      ],
    ),
  );
}

void showClearDialog(BuildContext context, Tooth tooth, TeethCubit cubit) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text(
        'إلغاء اختيار السن؟',
        style: TextStyle(fontSize: 18),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            cubit.clearTooth(tooth);
          },
          child: const Text('نعم', style: TextStyle(color: Colors.red)),
        )
      ],
    ),
  );
}
