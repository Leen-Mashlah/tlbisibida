import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/image_gallery.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/case_details_table.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/case_process_timeline.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';

class CaseDetails extends StatelessWidget {
  CaseDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CasesCubit, String>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            CasesCubit casesCubit = context.read<CasesCubit>();

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 10, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CaseProcessTimeline(
                        currentProcessIndex:
                            casesCubit.medicalCase!.medicalCaseDetails!.status!,
                        onProcessIndexChanged: (value) {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 400,
                            height:
                                (MediaQuery.of(context).size.height / 1.3) - 50,
                            decoration: BoxDecoration(
                                color: cyan300,
                                border: Border.all(color: cyan300, width: .5),
                                borderRadius: BorderRadius.circular(50)),
                            child: const CaseDetailsTable(),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 350,
                            height:
                                (MediaQuery.of(context).size.height / 1.3) - 50,
                            decoration: BoxDecoration(
                                color: cyan200,
                                border: Border.all(color: cyan300, width: .5),
                                borderRadius: BorderRadius.circular(50)),
                            // child: Image.asset(
                            //   fit: BoxFit.fill,
                            //   'diagram.jpg',
                            //   errorBuilder: (context, error, stackTrace) {
                            //     return Icon(Icons.do_not_disturb_outlined);
                            //   },
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ImageGallery(
                                imageUrls: [
                                  //TODO DOWNLOAD IMAGES
                                  'https://picsum.photos/200/300',
                                  'https://files.gamebanana.com/bitpit/diagram.jpg',
                                  'https://traveltodentist.com/wp-content/uploads/2020/04/dinti-noi-zirconiu-ceramica.jpg',
                                  'https://traveltodentist.com/wp-content/uploads/2020/04/dinti-afectati-de-parodontoza-1.jpg',
                                  'https://traveltodentist.com/wp-content/uploads/2020/04/caz-clinic-inainte-si-dupa-tratament-parodontoza-moldova.jpg',
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: cyan500, width: .5),
                                borderRadius: BorderRadius.circular(50)),
                            width: 400,
                            height:
                                (MediaQuery.of(context).size.height / 1.3) - 50,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'اسم الطبيب',
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.dentistFirstName} ${casesCubit.medicalCase!.dentistLastName}'),
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.patientFullName}'),
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
                                      Column(
                                        children: [
                                          Text(
                                            'العمر',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(
                                              '${casesCubit.medicalCase!.medicalCaseDetails!.age}'),
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

                                      Column(
                                        children: [
                                          Text(
                                            'الجنس',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(
                                              '${casesCubit.medicalCase!.patientGender}'),
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.medicalCaseDetails!.shade}'),
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.medicalCaseDetails!.createdAt}'),
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  Text(
                                      '${casesCubit.medicalCase!.medicalCaseDetails!.expectedDeliveryDate}'),
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
                                      Column(
                                        children: [
                                          const Text(
                                            'حالة إعادة',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(casesCubit.medicalCase!
                                                  .medicalCaseDetails!.repeat!
                                              ? 'نعم'
                                              : 'لا'),
                                          const SizedBox(
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
                                      Column(
                                        children: [
                                          const Text(
                                            'تحتاج إلى تجربة',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Text(casesCubit.medicalCase!
                                                  .medicalCaseDetails!.repeat!
                                              ? 'نعم'
                                              : 'لا'),
                                          const SizedBox(
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
                                    style:
                                        TextStyle(color: cyan600, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: cyan300, width: .3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: 250,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          '${casesCubit.medicalCase!.medicalCaseDetails!.notes}'),
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
                                  shadowColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                  backgroundColor:
                                      WidgetStatePropertyAll(cyan300)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.height / 6,
                                  ),
                                  Text(
                                    'التعليقات',
                                    style: TextStyle(color: white),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.height / 6,
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
            );
          },
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
