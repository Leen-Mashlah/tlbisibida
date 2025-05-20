import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/cases/components/case_details_table.dart';
import 'package:lambda_dent_dash/view/cases/components/case_process_timeline.dart';

class CaseDetails extends StatelessWidget {
  CaseDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CaseProcessTimeline(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        width: 400,
                        height: (MediaQuery.of(context).size.height / 1.3) - 50,
                        decoration: BoxDecoration(
                            color: cyan300,
                            border: Border.all(color: cyan300, width: .5),
                            borderRadius: BorderRadius.circular(50)),
                        child: const CaseDetailsTable(),
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        width: 350,
                        height: (MediaQuery.of(context).size.height / 1.3) - 50,
                        decoration: BoxDecoration(
                            color: cyan300,
                            border: Border.all(color: cyan300, width: .5),
                            borderRadius: BorderRadius.circular(50)),
                        child: Image.asset(
                          fit: BoxFit.fill,
                          'diagram.jpg',
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.do_not_disturb_outlined);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: cyan500, width: .5),
                            borderRadius: BorderRadius.circular(50)),
                        width: 400,
                        height: (MediaQuery.of(context).size.height / 1.3) - 50,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'اسم الطبيب',
                                style: TextStyle(color: cyan600, fontSize: 16),
                              ),
                              const Text('د. محمود الزحيلي'),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                height: .3,
                                color: cyan300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'اسم المريض',
                                style: TextStyle(color: cyan600, fontSize: 16),
                              ),
                              const Text('تحسين النعسان'),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                height: .3,
                                color: cyan300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Column(
                                    children: [
                                      Text(
                                        'العمر',
                                        style: TextStyle(
                                            color: cyan600, fontSize: 16),
                                      ),
                                      Text('20'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  Container(
                                    height: 25,
                                    width: .5,
                                    color: cyan400,
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  const Column(
                                    children: [
                                      Text(
                                        'الجنس',
                                        style: TextStyle(
                                            color: cyan600, fontSize: 16),
                                      ),
                                      Text('ذكر'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                height: .3,
                                color: cyan300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'اللون',
                                style: TextStyle(color: cyan600, fontSize: 16),
                              ),
                              const Text('B2'),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                height: .3,
                                color: cyan300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'تاريخ إنشاء الطلب',
                                style: TextStyle(color: cyan600, fontSize: 16),
                              ),
                              const Text('6/10/2024'),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                height: .3,
                                color: cyan300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'تاريخ التسليم',
                                style: TextStyle(color: cyan600, fontSize: 16),
                              ),
                              const Text('20/10/2024'),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                height: .3,
                                color: cyan300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Column(
                                    children: [
                                      Text(
                                        ' حالة إعادة',
                                        style: TextStyle(
                                            color: cyan600, fontSize: 16),
                                      ),
                                      Text('لا'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  Container(
                                    height: 25,
                                    width: .5,
                                    color: cyan400,
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  const Column(
                                    children: [
                                      Text(
                                        'تحتاج إلى تجربة',
                                        style: TextStyle(
                                            color: cyan600, fontSize: 16),
                                      ),
                                      Text('نعم'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                height: .3,
                                color: cyan300,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'الملاحظات',
                                style: TextStyle(color: cyan600, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: cyan300, width: .3),
                                    borderRadius: BorderRadius.circular(20)),
                                width: 250,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'تىتى لااتنا الااالا انم قيقي صغقه يقخميغف غفبفغي غفبغفبف فغبغفبف غفبفب فبفغب هعلالا 44 ممغع برفالؤ غبفبفب عغنلا '),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height / 5,
                right: 0,
                child: Builder(
                  builder: (context) => RotatedBox(
                    quarterTurns: 3,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(100),
                                          bottom: Radius.circular(5)))),
                              elevation: WidgetStatePropertyAll(0),
                              shadowColor:
                                  WidgetStatePropertyAll(Colors.transparent),
                              backgroundColor: WidgetStatePropertyAll(cyan300)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.height / 6,
                              ),
                              Text(
                                'التعليقات',
                                style: TextStyle(color: white),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.height / 6,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              SizedBox(
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
              Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero, // Ensure no extra padding
                    itemCount: messages.length,
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
                    onSend: (_) {
                      messages.add({
                        'text': _,
                        'color': cyan400,
                        'tail': true,
                        'isSender': true
                      });
                      print(_);
                    }),
              ),
            ],
          ),
        ));
  }

  Widget chatBubbleBuilder(
    BuildContext context,
    int index,
  ) {
    final message = messages[index];
    return BubbleSpecialThree(
      text: message['text'],
      color: message['color'],
      tail: message['tail'],
      isSender: message['isSender'],
      textStyle: TextStyle(
        color: message['isSender'] == false ? Colors.black : Colors.white,
        fontSize: 16,
      ),
    );
  }

  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Added iMessage shape bubbles',
      'color': cyan400,
      'tail': false,
      'isSender': true,
    },
    {
      'text': 'Please try and give some feedback on it!',
      'color': cyan400,
      'tail': true,
      'isSender': true,
    },
    {
      'text': 'Sure',
      'color': cyan50,
      'tail': false,
      'isSender': false,
    },
    {
      'text': "I tried. It's awesome!!!",
      'color': cyan50,
      'tail': false,
      'isSender': false,
    },
    {
      'text': "Thanks",
      'color': cyan50,
      'tail': true,
      'isSender': false,
    },
  ];
}
