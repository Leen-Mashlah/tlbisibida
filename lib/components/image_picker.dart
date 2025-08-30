import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';

Widget imagePicker(List<Image> images, {Function(Uint8List)? onImagePicked}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // Get both widget and bytes
              final pickedFile = await ImagePickerWeb.getImageAsWidget();
              final pickedBytes = await ImagePickerWeb.getImageAsBytes();

              setState(() {
                if (pickedFile != null) {
                  images.add(pickedFile);
                }
              });

              // Call callback with bytes if provided
              if (pickedBytes != null && onImagePicked != null) {
                onImagePicked(pickedBytes);
              }
            },
            child: Icon(Icons.image_search),
          ),
          // const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: images.map((image) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: image,
                ),
              );
            }).toList(),
          ),
        ],
      );
    },
  );
}
