import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/components/float_button.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';

class CasesListPage extends StatelessWidget {
  const CasesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 500,
              width: 1000,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Container(
                    //   height: 50,
                    //   width: 50,
                    //   color: cyan400,
                    // ),
                    _column('To Do', const Icon(Icons.checklist), cyan400),
                    _column('In Progress',
                        const Icon(Icons.work_history_rounded), Colors.amber),
                    _column('Need Confirmation',
                        const Icon(Icons.warning_rounded), Colors.redAccent),
                    // _columnEntity(),
                  ]),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: floatButton(
              icon: Icons.add,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

Widget _column(String title, Widget icon, Color color) {
  return SizedBox(
    width: 300,
    height: 800,
    child: Column(
      children: [
        Container(
            height: 60,
            //width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: color, borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                          child: Text(
                        '5',
                        style: TextStyle(color: white),
                      )),
                    )
                  ]),
            ))),
        Expanded(
            child: ListView.separated(
          itemBuilder: (context, index) {
            return _itembuilder(context, icon, color);
          },
          itemCount: 5,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 25,
            );
          },
        ))
      ],
    ),
  );
}

Widget _itembuilder(
  context,
  Widget icon,
  Color color,
) {
  return InkWell(
    onTap: () => locator<NavigationService>().navigateTo(caseDetailsPageRoute),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(5)),
                child: icon),
            const SizedBox(
              height: 10,
            ),
            const Text('Client Name'),
            const SizedBox(
              height: 10,
            ),
            const Text('Patient Name'),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: cyan100),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      color: cyan500,
                      Icons.timer,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '2024/11/15',
                      style: TextStyle(
                        color: cyan500,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
