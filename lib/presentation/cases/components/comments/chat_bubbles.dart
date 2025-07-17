import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';

Widget chatBubbleBuilder(
  BuildContext context,
  int index,
) {
  final cubit = context.read<CasesCubit>();

  final message = cubit.comments![index];
  bool isSender = message.labManagerId != null;

  return BubbleSpecialThree(
    text: message.comment!,
    color: isSender == false ? cyan400 : cyan50,
    // tail: message['tail'],
    isSender: isSender,
    textStyle: TextStyle(
      color: isSender == false ? Colors.black : Colors.white,
      fontSize: 16,
    ),
  );
}
