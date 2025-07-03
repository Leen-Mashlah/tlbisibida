 import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget percentCircle(BuildContext context, Map pageInfo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularPercentIndicator(
        radius: 75,
        lineWidth: 5,
        percent: pageInfo['quantity'] / pageInfo['standard_quantity'] > 1
            ? 1
            : pageInfo['quantity'] / pageInfo['standard_quantity'],
        progressColor:
            pageInfo['quantity'] / pageInfo['standard_quantity'] < 0.4
                ? Colors.redAccent
                : cyan400,
        arcType: ArcType.HALF,
        arcBackgroundColor: cyan100,
        animation: true,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageInfo['quantity'].toString(),
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              height: 1.5,
              width: 50,
              color: Colors.black,
            ),
            Text(
              pageInfo['standard_quantity'].toString(),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        animationDuration: 1500,
        curve: Curves.fastEaseInToSlowEaseOut,
        // footer: Text(
        //   // page_info['name']!,
        //   textAlign: TextAlign.center,
        //   style: TextStyle(fontSize: 16),
        // ),
      ),
    );
  }
