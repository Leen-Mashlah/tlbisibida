import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Widget imagePickerPro(List<Image> images) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        children: [
          IconButton(
            onPressed: () async {
              final pickedFile = await ImagePickerWeb.getImageAsWidget();
              setState(() {
                if (pickedFile != null) {
                  images.add(pickedFile);
                }
              });
            },
            icon: const Icon(
              Icons.image_search,
              color: cyan500,
            ),
          ),
        ],
      );
    },
  );
}
