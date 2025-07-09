import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_popup/info_popup.dart';

import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';

import 'package:lambda_dent_dash/presentation/clients/components/tables/client_bills_table.dart';
import 'package:lambda_dent_dash/presentation/clients/components/tables/client_cases_table.dart';
import 'package:lambda_dent_dash/presentation/clients/components/dialogs/payments_log_dialog.dart';
import 'package:lambda_dent_dash/presentation/payments/components/dialogs/add_constant_payment_dialog.dart';
// import 'package:lambda_dent_dash/view/clients/clients_table.dart';

class ClientDetailsPage extends StatelessWidget {
  ClientDetailsPage({super.key});
  //List choices = ['cases', 'bills'];
  final ValueNotifier<bool> _iscase = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ClientsCubit, String>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ClientsCubit clientsCubit = context.read<ClientsCubit>();
        return SingleChildScrollView(
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
                                itemCount: 2,
                                itemBuilder: (state, i) {
                                  final bool isCasesTab = i == 0;
                                  return ChoiceChip(
                                    selectedColor: cyan200,
                                    side: const BorderSide(color: cyan300),
                                    selected: state.selected(isCasesTab),
                                    onSelected: state.onSelected(isCasesTab),
                                    label: Text(
                                        isCasesTab ? 'الحالات' : 'الفواتير'),
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
                              showpaymentlog(context),
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
                                    style:
                                        TextStyle(fontSize: 14, color: cyan600),
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
                                    style:
                                        TextStyle(fontSize: 14, color: cyan600),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'تحسين التحسيني',
                                    style:
                                        TextStyle(fontSize: 18, color: cyan600),
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
                ValueListenableBuilder(
                    valueListenable: _iscase,
                    builder: (context, isShowingCases, child) {
                      if (isShowingCases && state == 'client_cases_loaded') {
                        return const ClientCasesTable();
                      } else if (!isShowingCases &&
                          state == 'client_bills_loaded') {
                        return const ClientBillsTable();
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
        );
      },
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
