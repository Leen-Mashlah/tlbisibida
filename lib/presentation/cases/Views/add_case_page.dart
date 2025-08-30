// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/date_picker.dart';
import 'package:lambda_dent_dash/components/default_textfield.dart';
import 'package:lambda_dent_dash/components/image_picker.dart';
import 'package:lambda_dent_dash/components/teeth_selection_screen.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/shade_guides/guide_button.dart';
import 'package:lambda_dent_dash/presentation/cases/Components/search_for_client.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_cubit.dart';
import 'package:lambda_dent_dash/presentation/cases/Cubits/cases_state.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/data/repo/db_clients_repo.dart';
import 'package:lambda_dent_dash/data/repo/db_cases_repo.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';

class AddCasePage extends StatelessWidget {
  AddCasePage({super.key});

  var formkey = GlobalKey<FormState>();
  List<Image> images = [];

  // Screenshot controller for capturing teeth selection
  final ScreenshotController _screenshotController = ScreenshotController();

  // Form validation method
  String? _validateForm(CasesCubit cubit) {
    if (cubit.selectedClientId == null) {
      return 'يرجى اختيار الطبيب';
    }
    if (cubit.patientFullName.trim().isEmpty) {
      return 'يرجى إدخال اسم المريض';
    }
    if (cubit.patientPhone.trim().isEmpty) {
      return 'يرجى إدخال رقم هاتف المريض';
    }
    if (cubit.shade.trim().isEmpty) {
      return 'يرجى اختيار لون الأسنان';
    }
    if (cubit.getSelectedTeeth.values.expand((list) => list).isEmpty) {
      return 'يرجى اختيار الأسنان المطلوب علاجها';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClientsCubit>(
          create: (context) => ClientsCubit(locator<DBClientsRepo>()),
        ),
        BlocProvider<CasesCubit>(
          create: (context) => CasesCubit(locator<DBCasesRepo>()),
        ),
      ],
      child: BlocConsumer<CasesCubit, CasesState>(listener: (context, state) {
        if (state is CasesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      }, builder: (context, state) {
        final casesCubit = context.read<CasesCubit>();

        // Clear images when page is initialized
        WidgetsBinding.instance.addPostFrameCallback((_) {
          casesCubit.clearImages();
        });

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 5,
                        colors: const [cyan200, cyan400, cyan200],
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'موعد التسليم:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              datePicker(
                                context,
                                casesCubit.expectedDeliveryDate,
                                onDateChanged: (date) {
                                  casesCubit.updateExpectedDeliveryDate(date);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            color: cyan300,
                            width: 200,
                            height: .5,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextField(
                            TextEditingController(text: casesCubit.notes),
                            context,
                            'ملاحظات',
                            inactiveColor: cyan100,
                            prefixIcon: Icon(Icons.edit_note),
                            height: 5,
                            maxLines: 5,
                            onChanged: (value) {
                              casesCubit.updateNotes(value);
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            color: cyan300,
                            width: 200,
                            height: .5,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          imagePicker(
                            images,
                            onImagePicked: (Uint8List imageBytes) {
                              // Add manual image to cubit when picked
                              casesCubit.addManualImage(imageBytes);
                              print(
                                  'Manual image picked and added: ${imageBytes.length} bytes');

                              // Show feedback to user
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'تم إضافة الصورة (${casesCubit.totalImageCount} صورة)'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 5,
                        colors: const [cyan200, cyan400, cyan200],
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ChoiceButtonWithSearch(
                              hintText: 'اختر الزبون',
                              onClientSelected: (client) {
                                casesCubit.setSelectedClient(
                                    client.id, client.name);
                              },
                              clientsCubit: context.read<ClientsCubit>()),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: defaultTextField(
                                TextEditingController(
                                    text: casesCubit.patientFullName),
                                context,
                                'اسم المريض *',
                                inactiveColor: cyan100, onChanged: (value) {
                              casesCubit.updatePatientFullName(value);
                            }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: defaultTextField(
                                TextEditingController(
                                    text: casesCubit.patientPhone),
                                context,
                                'رقم الهاتف *',
                                inactiveColor: cyan100, onChanged: (value) {
                              casesCubit.updatePatientPhone(value);
                            }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'المواليد',
                                style: TextStyle(color: cyan600, fontSize: 16),
                              ),
                              datePicker(
                                context,
                                casesCubit.patientBirthdate,
                                onDateChanged: (date) {
                                  casesCubit.updatePatientBirthdate(date);
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: cyan50,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'ذكر',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Radio<String>(
                                              value: 'ذكر',
                                              groupValue:
                                                  casesCubit.patientGender,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  casesCubit
                                                      .updatePatientGender(
                                                          value);
                                                }
                                              }),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'أنثى',
                                            style: TextStyle(
                                                color: cyan600, fontSize: 16),
                                          ),
                                          Radio<String>(
                                              value: 'أنثى',
                                              groupValue:
                                                  casesCubit.patientGender,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  casesCubit
                                                      .updatePatientGender(
                                                          value);
                                                }
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    color: cyan200,
                                    width: 150,
                                    height: .5,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'مدخن؟',
                                        style: TextStyle(
                                            color: cyan600, fontSize: 16),
                                      ),
                                      Checkbox(
                                        value: casesCubit.isSmoker,
                                        onChanged: (value) {
                                          if (value != null) {
                                            casesCubit.updateIsSmoker(value);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ShadeSelectionButton(
                                onShadeSelected: (shadeName, shadeColor) {
                                  casesCubit.updateShade(shadeName);
                                },
                              ),
                              Container(
                                width: .5,
                                height: 100,
                                color: cyan300,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: casesCubit.repeat,
                                        onChanged: (value) {
                                          if (value != null) {
                                            casesCubit.updateRepeat(value);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      const Text('إعادة؟'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: casesCubit.needTrial,
                                        onChanged: (value) {
                                          if (value != null) {
                                            casesCubit.updateNeedTrial(value);
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      const Text('بحاجة تجربة؟'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Submit button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                // Validate form manually to show better error messages
                                String? errorMessage =
                                    _validateForm(casesCubit);
                                if (errorMessage == null) {
                                  try {
                                    // Capture screenshot of teeth selection
                                    final Uint8List? screenshotBytes =
                                        await _screenshotController.capture();

                                    if (screenshotBytes != null) {
                                      // Add screenshot to the images list as the first image
                                      casesCubit
                                          .addTeethScreenshot(screenshotBytes);
                                      print(
                                          'Screenshot captured successfully: ${screenshotBytes.length} bytes');
                                    } else {
                                      print('Failed to capture screenshot');
                                      // Show warning but continue with submission
                                    }

                                    // Manual images are already added to cubit when picked via callback
                                    // No need to convert them here

                                    // Submit the case
                                    final success =
                                        await casesCubit.addMedicalCase();
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('تم إضافة الحالة بنجاح'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      // Navigate back to cases list
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('فشل في إضافة الحالة'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('خطأ في التقاط صورة: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(errorMessage),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cyan500,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'إضافة الحالة',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (casesCubit.totalImageCount > 0)
                                    Text(
                                      '(${casesCubit.totalImageCount} صورة)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 5,
                        colors: const [cyan200, cyan500, cyan200],
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: Screenshot(
                            controller: _screenshotController,
                            child: TeethSelectionScreen(
                              asset: 'assets/teeth.svg',
                              isDocSheet: false,
                              onTeethDataChanged: (teethData) {
                                // Update the cases cubit with the teeth data
                                for (var entry in teethData.entries) {
                                  casesCubit.updateSelectedTeeth(
                                      entry.key, entry.value);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
