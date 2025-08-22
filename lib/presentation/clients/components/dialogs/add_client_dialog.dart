import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';

class AddClientDialog extends StatelessWidget {
  AddClientDialog({
    super.key,
    required this.clientsCubit,
  });

  final ClientsCubit clientsCubit;
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientPhoneController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'إضافة زبون محلياً',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: cyan200,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultTextField(
                        clientNameController, context, 'اسم الزبون'),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        clientPhoneController, context, 'رقم الهاتف'),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        clientAddressController, context, 'العنوان'),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              defaultButton(
                  text: 'إضافة',
                  function: () async {
                    final nameParts =
                        clientNameController.text.trim().split(' ');
                    final firstName =
                        nameParts.isNotEmpty ? nameParts.first : '';
                    final lastName = nameParts.length > 1
                        ? nameParts.sublist(1).join(' ')
                        : '';
                    final phone = clientPhoneController.text.trim();
                    final address = clientAddressController.text.trim();
                    final success = await clientsCubit.addLocalClient(
                      firstName: firstName,
                      lastName: lastName,
                      phone: phone,
                      address: address,
                    );
                    if (success) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('فشل في إضافة الزبون')),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
