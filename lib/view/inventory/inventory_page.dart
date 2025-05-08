import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/view/inventory/components/buttom_action_buttons.dart';
import 'package:lambda_dent_dash/view/inventory/components/dialogs/bottom_action_payments_log_buttons.dart';
import 'package:lambda_dent_dash/view/inventory/components/percent_gauge.dart';
import 'package:lambda_dent_dash/view/inventory/components/pie_chart.dart';
import 'package:lambda_dent_dash/view/inventory/components/triangle_card.dart';

class InventoryPage extends StatelessWidget {
  InventoryPage({super.key});

  List<Map> info = [
    {
      'name': 'سماكة 12',
      'quantity': 150,
      'standard_quantity': 50,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 200,
      'standard_quantity': 100,
      'minimum': 40,
    },
    {
      'name': 'سماكة 12',
      'quantity': 120,
      'standard_quantity': 90,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 10,
      'standard_quantity': 70,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 120,
      'standard_quantity': 90,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 10,
      'standard_quantity': 70,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 120,
      'standard_quantity': 90,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 10,
      'standard_quantity': 70,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 120,
      'standard_quantity': 90,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 10,
      'standard_quantity': 70,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 120,
      'standard_quantity': 90,
      'minimum': 20,
    },
    {
      'name': 'سماكة 12',
      'quantity': 10,
      'standard_quantity': 70,
      'minimum': 20,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 700,
            child: const InteractiveDonutChart()
                .animate()
                .rotate(duration: const Duration(minutes: 60), begin: -20),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: SizedBox(
              width: 600,
              child: GridView.count(
                  childAspectRatio: 1,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 15,
                  children: List.generate(
                          info.length,
                          (index) => itemcard(context, info, index, onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InventoryPage()));
                              }))
                      .animate(
                        interval: const Duration(milliseconds: 50),
                      )
                      .slide(duration: const Duration(milliseconds: 300))
                      .fadeIn(
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 250))
                      .flip(duration: const Duration(milliseconds: 200))),
            ),
          )
        ],
      ),
    );
  }

  Widget itemcard(BuildContext context, List info, int index,
      {VoidCallback? onTap}) {
    return FlipCard(
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL, // default
        side: CardSide.FRONT, // The side to initially display.
        front: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      info[index]['name'],
                      style: const TextStyle(color: cyan500, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: .5,
                      width: 100,
                      color: cyan200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 170,
                        child: percentCircle(context, info[index])),
                  ],
                ),
              ),
              bottomActionPaymentsLogButtons(context),
            ],
          ),
        ),
        back: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      info[index]['name'],
                      style: const TextStyle(color: cyan500, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: .5,
                      width: 100,
                      color: cyan200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipPath(
                      clipper: TriangleCard(),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                          height: 170,
                          width: 250,
                          color: cyan50,
                          child: SingleChildScrollView(
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('سعر العنصر الواحد/قطعة'),
                                Text(
                                  '50.000',
                                  style: TextStyle(color: cyan400),
                                ),
                                Text('تاريخ آخر شراء'),
                                Text(
                                  '2/5/2024',
                                  style: TextStyle(color: cyan300),
                                ),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text('الحد الادنى'),
                                Text(
                                  '50',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 228, 132, 132)),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              bottomActionButtons(context),
            ],
          ),
        ));
  }
}
