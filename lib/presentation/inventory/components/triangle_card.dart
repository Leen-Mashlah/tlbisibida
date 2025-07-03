import 'package:flutter/material.dart';

class TriangleCard extends CustomClipper<Path> {
  // _Triangle(int x,int y){}
  @override
  Path getClip(Size size) {
    final Path path = Path();
    //0,0
    path.lineTo(0, 0);
    path.lineTo(size.width / 3, size.height);
    path.lineTo(size.width * 2 / 3, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    // path.lineTo(size.width/2, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    //   path.lineTo(size.width / 2, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
