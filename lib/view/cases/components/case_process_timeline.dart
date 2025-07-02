import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/cases/components/cost_dialog.dart';
import 'package:timelines_plus/timelines_plus.dart';


const kTileHeight = 50.0;
const completeColor = Color(0xff5e6172);
const inProgressColor = cyan300;
const todoColor = Color(0xffd1d2d7);

const _processes = [
  'الطلب',
  'تم التأكيد',
  'قيد الإنجاز',
  'جاهزة',
  'تم التسليم',
];

class CaseProcessTimeline extends StatefulWidget {
  const CaseProcessTimeline({super.key});

  @override
  State<CaseProcessTimeline> createState() => _CaseProcessTimelineState();
}

class _CaseProcessTimelineState extends State<CaseProcessTimeline> {
  int _processIndex = 1;

  Color getColor(int index) {
    if (index == _processIndex) {
      return cyan300;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  void _nextProcess() async {
    if (_processIndex == 2) {
      // If currently at "قيد الإنجاز", show the cost dialog
      final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return const CostDialog(); // Use your separate CostDialog widget
        },
      );

      // Check if a cost was submitted (result is not null)
      if (result != null) {
        print("Received cost from dialog: $result");
        // Update the process index only if a cost was submitted
        setState(() {
          _processIndex = 3; // Move to "جاهزة"
        });
      }
    } else if (_processIndex != _processes.length - 1) {
      // For other stages, just increment the index
      setState(() {
        _processIndex = (_processIndex + 1) % (_processes.length + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width / 5.5,
          child: Timeline.tileBuilder(
            theme: TimelineThemeData(
              direction: Axis.horizontal,
              connectorTheme: const ConnectorThemeData(
                space: 5.0,
                thickness: 5.0,
              ),
            ),
            builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemExtentBuilder: (_, __) =>
                  MediaQuery.of(context).size.width / 5.5 / _processes.length,
              oppositeContentsBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    _processes[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: getColor(index),
                    ),
                  ),
                );
              },
              indicatorBuilder: (_, index) {
                var color;
                Widget? child; // Made nullable
                if (index == _processIndex) {
                  color = inProgressColor;
                  child = const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                } else if (index < _processIndex) {
                  color = completeColor;
                  child = const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15.0,
                  );
                } else {
                  color = todoColor;
                }

                if (index <= _processIndex) {
                  return Stack(
                    children: [
                      CustomPaint(
                        size: const Size(30.0, 30.0),
                        painter: _BezierPainter(
                          color: color,
                          drawStart: index > 0,
                          drawEnd: index < _processIndex,
                        ),
                      ),
                      DotIndicator(
                        size: 30.0,
                        color: color,
                        child: child,
                      ),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      CustomPaint(
                        size: const Size(15.0, 15.0),
                        painter: _BezierPainter(
                          color: color,
                          drawEnd: index < _processes.length - 1,
                        ),
                      ),
                      OutlinedDotIndicator(
                        borderWidth: 4.0,
                        color: color,
                      ),
                    ],
                  );
                }
              },
              connectorBuilder: (_, index, type) {
                if (index > 0) {
                  if (index == _processIndex) {
                    final prevColor = getColor(index - 1);
                    final color = getColor(index);
                    List<Color> gradientColors;
                    if (type == ConnectorType.start) {
                      gradientColors = [
                        color,
                        Color.lerp(prevColor, color, 0.5)!,
                      ];
                    } else {
                      gradientColors = [
                        Color.lerp(prevColor, color, 0.5)!,
                        prevColor,
                      ];
                    }
                    return DecoratedLineConnector(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                        ),
                      ),
                    );
                  } else {
                    return SolidLineConnector(
                      color: getColor(index),
                    );
                  }
                } else {
                  return null;
                }
              },
              itemCount: _processes.length,
            ),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(cyan300)),
          onPressed: _nextProcess, // Call the new _nextProcess method
          child: const Icon(
            Icons.navigate_next_rounded,
            color: white,
          ),
        ),
      ],
    );
  }
}

/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
