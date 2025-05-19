import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Widget searchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 1.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 10,
          height: 50,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('ابحث عن عنصر..'),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.search,
          color: cyan500,
          size: 25,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}
