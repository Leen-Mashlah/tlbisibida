import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:info_popup/info_popup.dart';

import 'package:lambda_dent_dash/constants/constants.dart';

import 'package:lambda_dent_dash/view/clients/components/tables/client_bills_table.dart';
import 'package:lambda_dent_dash/view/clients/components/tables/client_cases_table.dart';
import 'package:lambda_dent_dash/view/clients/components/dialogs/payments_log_dialog.dart';
import 'package:lambda_dent_dash/view/payments/components/dialogs/add_constant_payment_dialog.dart';
import 'package:lottie/lottie.dart';
// import 'package:lambda_dent_dash/view/clients/clients_table.dart';

class ClientDetailsPage extends StatelessWidget {
  ClientDetailsPage({super.key});
  List choices = ['cases', 'bills'];
  final ValueNotifier<bool> _iscase = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: InlineChoice<bool>.single(
                            value: _iscase.value,
                            onChanged: (value) {
                              value == null ? value = false : value = value;
                              _iscase.value = value;
                            },
                            clearable: false,
                            itemCount: choices.length,
                            itemBuilder: (state, i) {
                              return ChoiceChip(
                                selectedColor: cyan200,
                                side: const BorderSide(color: cyan300),
                                selected: state.selected(
                                    choices[i] == 'cases' ? true : false),
                                onSelected: state.onSelected(
                                    choices[i] == 'cases' ? true : false),
                                label: Text(choices[i] == 'cases'
                                    ? 'الحالات'
                                    : 'الفواتير'),
                              );
                            },
                            listBuilder: ChoiceList.createWrapped(
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                direction: Axis.horizontal,
                                textDirection: TextDirection.rtl,
                                //spacing: 10,
                                //runSpacing: 10,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ))),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          // TextButton(
                          //     onPressed: () {
                          //       showDialog(
                          //         context: context,
                          //         builder: (context) => paymentLogDialog(context),
                          //       );
                          //     },
                          //     child: const Text('300.000.000')),
                          showpaymentlog(context),
                          // Text(
                          //   '3.000.000',
                          //   style: TextStyle(fontSize: 18),
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.credit_card_rounded,
                            color: cyan500,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'دمشق - السبع بحرات',
                                style: TextStyle(fontSize: 14, color: cyan600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.location_on_rounded,
                                color: cyan500,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          Row(
                            children: [
                              Text(
                                '0945454545',
                                style: TextStyle(fontSize: 14, color: cyan600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.phone_rounded,
                                color: cyan500,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'تحسين التحسيني',
                                style: TextStyle(fontSize: 18, color: cyan600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.person_2_rounded,
                                color: cyan500,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        // child: Container(
                        //   width: 60,
                        //   height: 60,
                        //   decoration: BoxDecoration(
                        //       color: cyan500,
                        //       borderRadius: BorderRadius.circular(50),
                        //       border: Border.all(
                        //         color: cyan300,
                        //         width: .5,
                        //       )),
                        // ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/id/1371009338/photo/portrait-of-confident-a-young-dentist-working-in-his-consulting-room.jpg?s=612x612&w=0&k=20&c=I212vN7lPpAOwGKRoEY9kYWunJaMj9vH2g-8YBGc2MI=',
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              Image.asset('assets/person.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedBuilder(
                animation: _iscase,
                builder: (context, child) => !_iscase.value
                    ? const ClientBillsTable()
                    : const ClientCasesTable()),
          ],
        ),
      ),
    ));
  }

  Positioned showpaymentlog(BuildContext context) {
    return Positioned(
      // bottom: 505,
      // right: 100,
      child: InfoPopupWidget(
        enabledAutomaticConstraint: false,
        arrowTheme: const InfoPopupArrowTheme(arrowSize: Size(0, 0)),
        contentOffset: const Offset(0, 0),
        customContent: () => Container(
          decoration: const BoxDecoration(
              color: cyan50op,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(53, 100),
                  right: Radius.elliptical(25, 40))),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          height: 60,
          child: const Text(
            'سجل الدفعات',
            style: TextStyle(color: cyan500),
          ),
        ),
        child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AddConstantPaymentDialog());
            },
            child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => paymentLogDialog(context),
                  );
                },
                child: const Text('300,000,000'))),
      ),
    );
  }
}
