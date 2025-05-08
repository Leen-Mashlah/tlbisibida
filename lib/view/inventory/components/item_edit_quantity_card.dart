import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

Widget itemEditQuantityCard(BuildContext context, {VoidCallback? onTap}) {
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController itemstandardquantitycontroller =
      TextEditingController();
  return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: FlipCard(
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          side: CardSide.FRONT, // The side to initially display.
          front: Card(
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                  color: cyan50op,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cyan500, width: .4)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('kg'),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 115,
                          child: defaultTextField(
                            itemnamecontroller,
                            context,
                            'الكمية المضافة',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 140,
                      child: defaultTextField(itemstandardquantitycontroller,
                          context, 'سعر الواحدة'),
                    ),
                  ],
                ),
              ),
            ),
            // child: SizedBox(
            //   height: 300,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             Text(
            //               info['name'],
            //               style: const TextStyle(color: cyan500, fontSize: 18),
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Container(
            //               height: .5,
            //               width: 100,
            //               color: cyan200,
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(20.0),
            //               child: percentCircle(context, info),
            //             ),
            //           ],
            //         ),
            //       ),
            //       bottomActionPaymentsLogButtons(context),
            //     ],
            //   ),
            // ),
          ),
          back: Card(
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(112, 255, 200, 206),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cyan500, width: .4)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 130,
                          child: defaultTextField(
                            itemnamecontroller,
                            context,
                            'الكمية المحذوفة',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('kg'),
                      ],
                    ),
                    // SizedBox(
                    //   width: 140,
                    //   child: defaultTextField(itemstandardquantitycontroller,
                    //       context, 'سعر الواحدة'),
                    // ),
                  ],
                ),
              ),
            ),
          )
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(11.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             Text(
          //               info['name'],
          //               style: const TextStyle(color: cyan500, fontSize: 18),
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Container(
          //               height: .5,
          //               width: 100,
          //               color: cyan200,
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             ClipPath(
          //               clipper: TriangleCard(),
          //               clipBehavior: Clip.antiAlias,
          //               child: Container(
          //                   height: 170,
          //                   width: 250,
          //                   color: cyan50,
          //                   child: SingleChildScrollView(
          //                     child: const Column(
          //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                       children: [
          //                         SizedBox(
          //                           height: 20,
          //                         ),
          //                         Text('سعر العنصر الواحد/قطعة'),
          //                         Text(
          //                           '50.000',
          //                           style: TextStyle(color: cyan400),
          //                         ),
          //                         Text('تاريخ آخر شراء'),
          //                         Text(
          //                           '2/5/2024',
          //                           style: TextStyle(color: cyan300),
          //                         ),
          //                         Text('الحد الادنى'),
          //                         Text(
          //                           '50',
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.w600,
          //                               color:
          //                                   Color.fromARGB(255, 228, 132, 132)),
          //                         ),
          //                       ],
          //                     ),
          //                   )),
          //             ),
          //           ],
          //         ),
          //       ),
          //       bottomActionButtons(context),
          //     ],
          //   ),
          // )),
          ));
}
