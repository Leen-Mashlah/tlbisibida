import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

import 'ivoclar_chromascop_guide.dart';
import 'vita_3dmaster_guide.dart';
import 'vita_classic_guide.dart';

class ShadeSelectionButton extends StatefulWidget {
  // Callback function that is called when a shade is selected from the guide.
  // This will pass the selected shade name (String) and color (Color) to the parent widget.
  final Function(String shadeName, Color shadeColor)? onShadeSelected;

  const ShadeSelectionButton({
    super.key,
    this.onShadeSelected, // Add the new callback parameter
  });

  @override
  _ShadeSelectionButtonState createState() => _ShadeSelectionButtonState();
}

class _ShadeSelectionButtonState extends State<ShadeSelectionButton> {
  // The currently selected shade name to display on the button.
  String? _selectedShadeName;
  // The color of the currently selected shade to use for the button's background.
  Color? _selectedShadeColor;

  // Function to show the dental shade guides in a bottom modal sheet.
  void _showShadeGuidesSheet() {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 1.1,
      ),
      isScrollControlled: true, // Allows the sheet to take up more height
      builder: (BuildContext context) {
        return DentalShadeGuidesModalContent(
          initialSelectedShade: _selectedShadeName,
          onShadeSelected: (shadeName, shadeColor) {
            // Update the state of the button when a shade is selected from any guide.
            setState(() {
              _selectedShadeName = shadeName;
              _selectedShadeColor = shadeColor;
            });
            // Call the parent widget's callback with the selected shade details.
            widget.onShadeSelected?.call(shadeName, shadeColor);
            // Close the modal sheet after selection.
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _showShadeGuidesSheet, // Show the modal sheet with guides
      style: ElevatedButton.styleFrom(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: cyan500, width: .5)),
        backgroundColor: _selectedShadeColor ?? cyan200,
        // Default color
        foregroundColor: _selectedShadeColor == null
            ? cyan600
            : _selectedShadeColor!.computeLuminance() > 0.5
                ? cyan500
                : cyan50, // Text color for contrast
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(
        _selectedShadeName ?? 'لون الأسنان', // Initial button text
      ),
    );
  }
}

// Content widget for the bottom modal sheet containing the expandable shade guides.
class DentalShadeGuidesModalContent extends StatefulWidget {
  final String? initialSelectedShade;
  final Function(String shadeName, Color shadeColor)? onShadeSelected;

  const DentalShadeGuidesModalContent({
    Key? key,
    this.initialSelectedShade,
    this.onShadeSelected,
  }) : super(key: key);

  @override
  _DentalShadeGuidesModalContentState createState() =>
      _DentalShadeGuidesModalContentState();
}

class _DentalShadeGuidesModalContentState
    extends State<DentalShadeGuidesModalContent> {
  // State to manage which panel is expanded.
  // Stores the index of the expanded panel, or null if none are expanded.
  int? _expandedPanelIndex;

  // Data structure for the expandable panels.
  // Each item represents a guide with a header and the guide widget itself.
  late List<ExpansionPanelItem> _panelItems;

  @override
  void initState() {
    super.initState();
    // Initialize the panel items with the different shade guides.
    _panelItems = [
      ExpansionPanelItem(
        headerText: 'Vita Classic',
        body: VitaShadeGuide(
          initialSelectedShade: widget.initialSelectedShade,
          onShadeSelected: widget.onShadeSelected,
        ),
      ),
      ExpansionPanelItem(
        headerText: 'Vita 3D Master',
        body: Vita3DMasterGuide(
          // Use the placeholder widget
          initialSelectedShade: widget.initialSelectedShade,
          onShadeSelected: widget.onShadeSelected,
        ),
      ),
      ExpansionPanelItem(
        headerText: 'Ivoclar Chromascop',
        body: IvoclarChromascopGuide(
          // Use the placeholder widget
          initialSelectedShade: widget.initialSelectedShade,
          onShadeSelected: widget.onShadeSelected,
        ),
      ),
    ];
  }

  // Function to handle panel expansion changes.
  void _handleExpansionChange(int index, bool isExpanded) {
    setState(() {
      // If a panel is being expanded, close the currently expanded one (if any)
      // and set the new one as expanded. If a panel is being collapsed, set
      // the expanded index to null.
      _expandedPanelIndex = isExpanded ? index : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the height of the modal sheet. Adjust as needed.
    final double sheetHeight = MediaQuery.of(context).size.height * 0.45;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          border: Border.all(color: cyan500, width: 1),
          color: cyan100,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      height: sheetHeight,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Adjust padding for keyboard
      ),
      child: SingleChildScrollView(
        // Make the content scrollable
        child: ExpansionPanelList(
          expandIconColor: cyan500,
          expansionCallback: _handleExpansionChange, // Handle expansion changes
          children: _panelItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return ExpansionPanel(
              backgroundColor: cyan50,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    item.headerText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cyan500),
                  ),
                );
              },
              body: item.body, // The guide widget
              isExpanded: index ==
                  _expandedPanelIndex, // Check if this panel is expanded
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Helper class to represent an item in the ExpansionPanelList.
class ExpansionPanelItem {
  final String headerText;
  final Widget body;

  ExpansionPanelItem({
    required this.headerText,
    required this.body,
  });
}
