import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? alignment;
  final TextDirection? textDirection;

  const CustomText(
      {super.key, required this.text, this.size, this.color, this.weight, this.alignment, this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      textDirection: textDirection ?? TextDirection.rtl,
      style: TextStyle(
        
          fontSize: size ?? 16,
          color: color ?? Colors.black87,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
