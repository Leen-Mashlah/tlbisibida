import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

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
            icon: Icon(Icons.image_search),
          ),
          // const SizedBox(height: 10),
          // Wrap(
          //   direction: Axis.horizontal,
          //   children: images.map((image) {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         child: image,
          //         width: 100,
          //         height: 100,
          //       ),
          //     );
          //   }).toList(),
          // ),
        ],
      );
    },
  );
}
