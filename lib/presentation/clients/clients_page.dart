import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/float_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/clients/components/tables/client_requests_table.dart';
import 'package:lambda_dent_dash/view/clients/components/tables/clients_table.dart';
import 'package:lambda_dent_dash/view/clients/components/dialogs/add_client_dialog.dart';

class ClientsPage extends StatelessWidget {
  ClientsPage({super.key});

  List choices = ['registered', 'requests'];
  final ValueNotifier<bool> _showregisteredlist = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: 500,
                  child: InlineChoice<bool>.single(
                      value: _showregisteredlist.value,
                      onChanged: (value) {
                        value == null ? value = false : value = value;
                        _showregisteredlist.value = value;
                      },
                      clearable: false,
                      itemCount: choices.length,
                      itemBuilder: (state, i) {
                        return ChoiceChip(
                          selectedColor: cyan200,
                          side: const BorderSide(color: cyan300),
                          selected: state.selected(
                              choices[i] == 'registered' ? true : false),
                          onSelected: state.onSelected(
                              choices[i] == 'registered' ? true : false),
                          label: Text(choices[i] == 'registered'
                              ? 'الزبائن'
                              : 'طلبات الانضمام'),
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
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedBuilder(
                  animation: _showregisteredlist,
                  builder: (context, child) => !_showregisteredlist.value
                      ? const ClientsReqTable()
                      : const ClientsTable()),
            ],
          )),
          Positioned(
            bottom: 20,
            right: 20,
            child: floatButton(
              icon: Icons.add,
              onTap: () {
                showDialog(
                    context: context, builder: (context) => AddClientDialog());
              },
            ),
          ),
        ],
      ),
    ));
  }
}
