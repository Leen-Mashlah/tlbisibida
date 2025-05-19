// ignore_for_file: prefer_const_constructors

import 'dart:io'; // Keep if 'Image' type from dart:io is used by imagePicker, otherwise can be removed if 'Image' is flutter's Widget.
// Assuming Image is flutter's Widget for now. If it's dart:io's File/Image, adjust imports and types.

import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/components/image_picker%20_profile.dart';
import 'package:lambda_dent_dash/components/image_picker.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
// image_picker_web is used for web, but the Image type might be a Flutter widget.
// Let's assume 'Image' refers to 'Widget' or a specific type your imagePicker component handles.
// import 'package:image_picker_web/image_picker_web.dart'; // This might be used internally by your imagePicker component

// --- Ensure these imports point to your actual component and constant files ---
// import 'package:lambda_dent_dash/components/default_button.dart';
// import 'package:lambda_dent_dash/components/default_textfield.dart';
// import 'package:lambda_dent_dash/components/image_picker.dart';
// import 'package:lambda_dent_dash/constants/constants.dart';

// --- Placeholder for constants IF NOT defined in your constants.dart ---
// These are used by the _buildIconButton method.
// If cyan100 and cyan400 are defined in your 'constants.dart', you can remove these.
// const Color cyan100 =
//     Color(0xFFB2EBF2); // Example placeholder for a lighter cyan
// const Color cyan400 = Colors.cyan; // Example placeholder

// --- Placeholder for components IF NOT defined (for standalone testing) ---
// If you have your components defined and imported, you can remove these placeholders.

// Placeholder for defaultTextField - REMOVE IF YOU HAVE YOURS
Widget defaultTextField(
  TextEditingController controller,
  BuildContext context,
  String labelText, {
  Widget? postfixicon,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      suffixIcon: postfixicon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    ),
    keyboardType: keyboardType,
  );
}

// Placeholder for defaultButton - REMOVE IF YOU HAVE YOURS
Widget mydefaultButton(
    {required String text, required VoidCallback function, Color? color}) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? cyan300, // Use a default color if not provided
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      textStyle: const TextStyle(fontSize: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(text, style: const TextStyle(color: Colors.white)),
  );
}

// Placeholder for imagePicker widget - REMOVE IF YOU HAVE YOURS
// Widget imagePicker(List<Widget> images) {
//   return Container(
//     padding: const EdgeInsets.all(8.0),
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.grey),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Column(
//       children: [
//         const Text("Image Picker (Your Component)"),
//         const SizedBox(height: 10),
//         // This is just a visual placeholder; your component will have its own logic
//         if (images.isNotEmpty)
//           Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: images,
//           )
//         else
//           const Text("No images selected"),
//       ],
//     ),
//   );
// }
// --- End of Placeholders ---

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({
  const EditProfileDialog({
    super.key,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  // List to hold controllers for dynamic phone number fields
  final List<TextEditingController> _phoneNumberControllers = [
    TextEditingController()
  ];

  final TextEditingController _profilenameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  // Added separate controllers for specialization and lab manager
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _labManagerController = TextEditingController();

  // Assuming 'Image' is a Flutter Widget. If it's from dart:io or another package, adjust type.
  // List<Widget> _images =
  //     []; // Changed to List<Widget> for placeholder compatibility

  // Define cyan200 here if not imported, or ensure it's available from your constants
  // static const Color cyan200 = Colors.cyan; // Example, use your actual constant

  @override
  void dispose() {
    _profilenameController.dispose();
    _addressController.dispose();
    _specializationController.dispose();
    _labManagerController.dispose();

    for (var controller in _phoneNumberControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildPhoneNumberPostfixIcon(int index) {
    if (index == _phoneNumberControllers.length - 1) {
      return _buildIconButton(
        Icons.add_circle_rounded,
        cyan400, // Make sure cyan400 is available (from constants or defined locally)
        _addPhoneNumberField,
      );
    } else {
      return _buildIconButton(
        Icons.remove_circle_rounded,
        redmid,
        () => _removePhoneNumberField(index),
      );
    }
  }

  Widget _buildIconButton(
      IconData iconData, Color iconColor, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child:
          // Container(
          //   decoration: const BoxDecoration(
          //     color:
          //         cyan100, // Make sure cyan100 is available (from constants or defined locally)
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       bottomLeft: Radius.circular(20),
          //     ),
          //   ),
          // child:
          IconButton(
        icon: Icon(iconData, color: iconColor),
        onPressed: onPressed,
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
      ),
      //),
    );
  }

  void _addPhoneNumberField() {
    setState(() {
      _phoneNumberControllers.add(TextEditingController());
    });
  }

  void _removePhoneNumberField(int index) {
    if (_phoneNumberControllers.length > 1) {
      setState(() {
        _phoneNumberControllers[index].dispose();
        _phoneNumberControllers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Image> images = [];
    final List<String> provincesList = [
      'دمشق',
      'ريف دمشق',
      'القنيطرة',
      'درعا',
      'السويداء',
      'حمص',
      'حماة',
      'اللاذقية',
      'طرطوس',
      'حلب',
      'إدلب',
      'الرقة',
      'دير الزور',
      'الحسكة',
    ];
    String selectedProvince = 'المحافظة';
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'تعديل الملف الشخصي', // "Edit Profile"
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: cyan400),
              ),
              const SizedBox(height: 25),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: cyan200, // Make sure cyan200 is available
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ensure defaultTextField is available via import or placeholder
                    SizedBox(
                      width: 500,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 5,
                            child: defaultTextField(
                                _profilenameController, context, 'اسم المخبر'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(flex: 1, child: imagePickerPro(images)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    defaultTextField(
                        // Ensure defaultTextField is available
                        _labManagerController,
                        context,
                        'مدير المخبر'), // "Lab Manager"
                    // const SizedBox(height: 20),

                    const SizedBox(height: 20),
                    defaultTextField(
                        // Ensure defaultTextField is available
                        _specializationController,
                        context,
                        'الاختصاص'), // "Specialization"
                    const SizedBox(height: 20),

                    ..._phoneNumberControllers.asMap().entries.map((entry) {
                      int idx = entry.key;
                      TextEditingController controller = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: idx == _phoneNumberControllers.length - 1
                                ? 0
                                : 20.0),
                        child: defaultTextField(
                          // Ensure defaultTextField is available
                          controller,
                          context,
                          'رقم الهاتف ${idx + 1}', // "Phone Number [index]"
                          keyboardType: TextInputType.phone,
                          postfixicon: _buildPhoneNumberPostfixIcon(idx),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: 500,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownSearch<String>(
                              decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      // label: Text('المحافظة'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                              mode: Mode.form,
                              selectedItem: selectedProvince,
                              onChanged: (value) {
                                selectedProvince = value.toString();
                              },
                              items: (f, cs) => provincesList,
                              suffixProps: DropdownSuffixProps(
                                clearButtonProps:
                                    ClearButtonProps(isVisible: false),
                              ),
                              dropdownBuilder: (context, selectedItem) {
                                if (selectedItem == null) {
                                  return SizedBox.shrink();
                                }
                                return ListTile(
                                  titleAlignment: ListTileTitleAlignment.center,
                                  title: Text(selectedItem),
                                );
                              },
                              popupProps: PopupProps.menu(
                                disableFilter: true,
                                showSearchBox: true,
                                showSelectedItems: true,
                                itemBuilder:
                                    (ctx, item, isDisabled, isSelected) {
                                  return ListTile(
                                    selected: isSelected,
                                    title: Text(item),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          //
                          Expanded(
                            flex: 2,
                            child: defaultTextField(
                                // Ensure defaultTextField is available
                                _addressController,
                                context,
                                'العنوان'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // "Address"

                    Container(
                      decoration: BoxDecoration(
                          color: cyan50op,
                          borderRadius: BorderRadius.circular(20)),
                      width: 500,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'أوقات الدوام',
                            style: TextStyle(color: cyan400, fontSize: 14),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('من'),
                              CupertinoTimePickerButton(
                                mainColor: cyan400,
                                initialTime:
                                    const TimeOfDay(hour: 9, minute: 41),
                                onTimeChanged: (time) {},
                              ),
                              Text('إلى'),
                              CupertinoTimePickerButton(
                                mainColor: cyan400,
                                initialTime:
                                    const TimeOfDay(hour: 9, minute: 41),
                                onTimeChanged: (time) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 25),
                    // Ensure imagePicker is available via import or placeholder
                    // imagePicker(_images),

                    // const SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ), // Ensure defaultButton is available via import or placeholder
              defaultButton(
                  text: 'تعديل',
                  textsize: 18,
                  function: () {
                    showDialog(
                      builder: (context) => EditProfileDialog(),
                      context: context,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
