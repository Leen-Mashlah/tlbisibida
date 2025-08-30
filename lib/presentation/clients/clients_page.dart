import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/float_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';
import 'package:lambda_dent_dash/presentation/clients/components/tables/client_requests_table.dart';
import 'package:lambda_dent_dash/presentation/clients/components/tables/clients_table.dart';
import 'package:lambda_dent_dash/presentation/clients/components/dialogs/add_client_dialog.dart';

class ClientsPage extends StatelessWidget {
  ClientsPage({super.key});

  List choices = ['registered', 'requests'];
  final ValueNotifier<bool> _showregisteredlist = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      ClientsCubit clientsCubit = context.read<ClientsCubit>();

      // Initial load: request once via microtask to avoid triggering after dispose
      if (_showregisteredlist.value &&
          clientsCubit.clientsResponse == null &&
          state is! ClientsLoading &&
          state is! ClientsError) {
        Future.microtask(() {
          if (!clientsCubit.isClosed) {
            clientsCubit.getClients();
          }
        });
      }

      return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
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
                          if (value != null) {
                            _showregisteredlist.value = value;
                            // Trigger a reload of the relevant data when switching tabs
                            if (value) {
                              if (!clientsCubit.isClosed) {
                                // Reset loading state for clients tab
                                clientsCubit.resetClientsLoadingState();
                                clientsCubit.getClients();
                              }
                            } else {
                              if (!clientsCubit.isClosed) {
                                clientsCubit.getJoinRequests();
                              }
                            }
                          }
                        },
                        clearable: false,
                        itemCount: choices.length,
                        itemBuilder: (state, i) {
                          final bool isRegisteredTab = i == 0;

                          return ChoiceChip(
                            selectedColor: cyan200,
                            side: const BorderSide(color: cyan300),
                            selected: state.selected(isRegisteredTab),
                            onSelected: state.onSelected(isRegisteredTab),
                            label: Text(
                                isRegisteredTab ? 'الزبائن' : 'طلبات الانضمام'),
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
                ValueListenableBuilder<bool>(
                  valueListenable: _showregisteredlist,
                  builder: (context, isShowingRegistered, child) {
                    if (isShowingRegistered && state is ClientsLoaded) {
                      return const ClientsTable();
                    } else if (!isShowingRegistered &&
                        state is RequestsLoaded) {
                      return const ClientsReqTable();
                    } else if (state is ClientsError) {
                      return const Center(
                          child: Text('حدث خطأ أثناء تحميل الزبائن'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            )),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Padding(
              padding: const EdgeInsets.all(20.0),
              // child: FloatingActionButton(
              //   onPressed: () {
              //     showDialog(
              //         context: context, builder: (context) => AddBillDialog());
              //   },
              //   child: Icon(
              //     Icons.add,
              //     color: cyan400,
              //     size: 25.0,
              //   ),
              //   backgroundColor: cyan200,
              // ),
              child: floatButton(
                icon: Icons.add,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          AddClientDialog(clientsCubit: clientsCubit));
                },
              )));
    });
  }
}
