import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

class CustomChoiceItem extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final ValueChanged<bool> onSelect;
  const CustomChoiceItem({
    super.key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: cyan500,
      dashPattern: [7, 2],
      borderType: BorderType.Circle,
      child: AnimatedContainer(
        width: width,
        height: height,
        margin: margin,
        duration: const Duration(milliseconds: 200),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: [cyan500, cyan300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
              : SweepGradient(
                  colors: [cyan100, cyan200, cyan300],
                  center: Alignment.topCenter),
          // : const RadialGradient(
          //     colors: [
          //       Color.fromARGB(62, 211, 241, 238),
          //
          //     ],

          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          // color: cyan100,
          borderRadius: BorderRadius.all(Radius.circular(selected ? 100 : 40)),
          border: Border.all(
            color: selected ? (color ?? cyan200) : cyan200,
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 40)),
          onTap: () => onSelect(!selected),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0),
              //   child: AnimatedCheckmark(
              //     active: selected,
              //     color: Colors.white,
              //     size: const Size.square(32),
              //     weight: 5,
              //     duration: const Duration(milliseconds: 200),
              //   ),
              // ),
              Positioned(
                // left: 9,
                // right: 9,
                // bottom: 10,
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: selected ? Colors.white : cyan600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
