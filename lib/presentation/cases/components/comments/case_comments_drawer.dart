import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/comments/chat_bubbles.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';

Widget caseComments(BuildContext context) {
  final cubit = context.read<CasesCubit>();

  return Drawer(
    width: MediaQuery.of(context).size.width / 3,
    child: Column(
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: cyan300,
            ),
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(10),
            child: Text(
              "التعليقات",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 1,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero, // Ensure no extra padding
              itemCount: cubit.comments!.length,
              itemBuilder: (context, index) =>
                  chatBubbleBuilder(context, index)),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom), // Accounts for keyboard height
          child: MessageBar(
              messageBarHintText: 'اكتب تعليقك هنا',
              sendButtonColor: cyan400,
              onSend: (text) async {
                final caseId = cubit.medicalCase?.medicalCaseDetails?.id;
                if (caseId != null && text.trim().isNotEmpty) {
                  await cubit.sendCaseComment(
                      caseId: caseId, comment: text.trim());
                }
              }),
        ),
      ],
    ),
  );
}



// final List<Map<String, dynamic>> messages = [
//   {
//     'text': 'Added iMessage shape bubbles',
//     'color': cyan400,
//     'tail': false,
//     'isSender': true,
//   },
//   {
//     'text': 'Please try and give some feedback on it!',
//     'color': cyan400,
//     'tail': true,
//     'isSender': true,
//   },
//   {
//     'text': 'Sure',
//     'color': cyan50,
//     'tail': false,
//     'isSender': false,
//   },
//   {
//     'text': "I tried. It's awesome!!!",
//     'color': cyan50,
//     'tail': false,
//     'isSender': false,
//   },
//   {
//     'text': "Thanks",
//     'color': cyan50,
//     'tail': true,
//     'isSender': false,
//   },
// ];
