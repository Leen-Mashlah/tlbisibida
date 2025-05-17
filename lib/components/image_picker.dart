import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

Widget imagePicker(List<Image> images) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final pickedFile = await ImagePickerWeb.getImageAsWidget();
              setState(() {
                if (pickedFile != null) {
                  images.add(pickedFile);
                }
              });
            },
            child: const SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Pick Image'),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.image_search)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
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
