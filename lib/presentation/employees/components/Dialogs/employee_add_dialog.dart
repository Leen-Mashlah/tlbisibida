// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/employees/Cubits/employees_cubit.dart';
import 'package:lambda_dent_dash/presentation/employees/Cubits/employees_state.dart';

class EmployeeAddDialog extends StatefulWidget {
  final EmployeesCubit employeesCubit;

  const EmployeeAddDialog({
    super.key,
    required this.employeesCubit,
  });

  @override
  State<EmployeeAddDialog> createState() => _EmployeeAddDialogState();
}

class _EmployeeAddDialogState extends State<EmployeeAddDialog> {
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeEmailController =
      TextEditingController();
  final TextEditingController _employeePhoneController =
      TextEditingController();
  DateTime _startDate = DateTime.now();
  String? _selectedGuard;
  bool _isLoading = false;

  @override
  void dispose() {
    _employeeNameController.dispose();
    _employeeEmailController.dispose();
    _employeePhoneController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    if (_employeeNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال اسم الموظف')),
      );
      return false;
    }
    if (_employeeEmailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال البريد الإلكتروني')),
      );
      return false;
    }
    if (_employeePhoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال رقم الهاتف')),
      );
      return false;
    }
    if (_selectedGuard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار نوع الموظف')),
      );
      return false;
    }
    return true;
  }

  void _submitForm() {
    if (!_validateForm()) return;

    setState(() {
      _isLoading = true;
    });

    widget.employeesCubit
        .createEmployee(
      guard: _selectedGuard!,
      fullName: _employeeNameController.text.trim(),
      email: _employeeEmailController.text.trim(),
      phone: _employeePhoneController.text.trim(),
      workStartAt:
          _startDate.toIso8601String().split('T')[0], // Format as YYYY-MM-DD
    )
        .then((success) {
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إضافة الموظف بنجاح')),
          );
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('فشل في إضافة الموظف')),
          );
        }
      }
    }).catchError((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $error')),
        );
      }
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeesCubit, EmployeesState>(
      listener: (context, state) {
        if (state is EmployeesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: cyan200),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 1.5,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'إضافة موظف',
                          style: TextStyle(
                            color: cyan400,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: .5,
                          width: 100,
                          color: cyan200,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                        ),
                        defaultTextField(
                          _employeeNameController,
                          context,
                          'اسم الموظف',
                        ),
                        const SizedBox(height: 10),
                        defaultTextField(
                          _employeeEmailController,
                          context,
                          'البريد الالكتروني',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        defaultTextField(
                          _employeePhoneController,
                          context,
                          'رقم الهاتف',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'accountant',
                                  groupValue: _selectedGuard,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGuard = value;
                                    });
                                  },
                                ),
                                Text(
                                  'محاسب',
                                  style: TextStyle(
                                    color: _selectedGuard == 'accountant'
                                        ? cyan600
                                        : Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'inventory_employee',
                                  groupValue: _selectedGuard,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGuard = value;
                                    });
                                  },
                                ),
                                Text(
                                  'مدير مخزن',
                                  style: TextStyle(
                                    color:
                                        _selectedGuard == 'inventory_employee'
                                            ? cyan600
                                            : Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'تاريخ بدء العمل',
                              style: TextStyle(color: cyan600, fontSize: 16),
                            ),
                            const SizedBox(width: 10),
                            datePicker(
                              context,
                              _startDate,
                              onDateChanged: (date) {
                                setState(() {
                                  _startDate = date;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        defaultButton(
                          text: _isLoading ? 'جاري الإضافة...' : 'إضافة',
                          function: _isLoading ? () {} : _submitForm,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget employeeAddDialog(BuildContext context, EmployeesCubit employeesCubit) {
  return EmployeeAddDialog(employeesCubit: employeesCubit);
}
