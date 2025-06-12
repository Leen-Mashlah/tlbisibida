import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Import for ui.Color

// Widget for the Ivoclar Chromascop Shade Guide.
// This widget simulates the behavior needed for integration into the
// ShadeSelectionButton's modal sheet, with shades and layout based on Ivoclar Chromascop.
class IvoclarChromascopGuide extends StatefulWidget {
  // Callback function that is called when a shade is selected.
  // Returns both the shade name (String) and the shade color (Color).
  final Function(String shadeName, Color shadeColor)? onShadeSelected;

  // Optional initial selected shade name.
  final String? initialSelectedShade;

  const IvoclarChromascopGuide({
    Key? key,
    this.onShadeSelected,
    this.initialSelectedShade,
  }) : super(key: key);

  @override
  _IvoclarChromascopGuideState createState() => _IvoclarChromascopGuideState();
}

class _IvoclarChromascopGuideState extends State<IvoclarChromascopGuide> {
  // Define the Ivoclar Chromascop shades and their approximate colors.
  // Note: These colors are approximations.
  final Map<String, Color> _shades = {
    // Light shades
    '110': const Color(0xFFF8F0E8), // Light yellowish
    '120': const Color(0xFFF5E8E0), // Slightly less light yellowish
    '130': const Color(0xFFF0E0D8), // Medium yellowish

    // Yellowish shades
    '210': const Color(0xFFF5EEDA), // Light yellow
    '220': const Color(0xFFF0E4C7), // Medium yellow
    '230': const Color(0xFFE8DDA8), // Darker yellow

    // Greyish shades
    '310': const Color(0xFFE0E0DB), // Light greyish
    '320': const Color(0xFFD3D3CD), // Medium greyish
    '330': const Color(0xFFC0C0B8), // Darker greyish

    // Reddish shades
    '410': const Color(0xFFF0D8D0), // Light reddish
    '420': const Color(0xFFE8C8C0), // Medium reddish
    '430': const Color(0xFFE0B8B0), // Darker reddish

    // Brownish shades
    '510': const Color(0xFFD8C8A8), // Light brownish
    '520': const Color(0xFFD0B898), // Medium brownish
    '530': const Color(0xFFC8A888), // Darker brownish
  };

  // Define the order of the shades for display, grouped by type.
  final Map<String, List<String>> _shadeOrder = {
    'Light': ['110', '120', '130'],
    'Yellowish': ['210', '220', '230'],
    'Greyish': ['310', '320', '330'],
    'Reddish': ['410', '420', '430'],
    'Brownish': ['510', '520', '530'],
  };

  String? _selectedShade;

  @override
  void initState() {
    super.initState();
    _selectedShade = widget.initialSelectedShade;
  }

  void _handleShadeTap(String shadeName) {
    setState(() {
      _selectedShade = shadeName;
    });
    final shadeColor = _shades[shadeName] ?? Colors.grey;
    widget.onShadeSelected?.call(shadeName, shadeColor);
  }

  @override
  Widget build(BuildContext context) {
    // Assuming cyan400 is defined in your constants.dart
    // If not, you'll need to define it or replace it with an actual Color value.
    const Color cyan400 =
        Color(0xFF00BCD4); // Example color, replace with your actual value

    return SingleChildScrollView(
      // Overall horizontal scrolling for the entire guide
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        // Main Row to arrange categories horizontally
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align categories to the top
        children: _shadeOrder.entries.map((entry) {
          final category = entry.key;
          final shadesInCategory = entry.value;

          // Get the list of colors for the shades in this category
          final List<Color> categoryShadeColors = shadesInCategory
              .map((shadeName) => _shades[shadeName] ?? Colors.grey)
              .toList();

          return Padding(
            padding: const EdgeInsets.only(
                right: 24.0), // Spacing between category columns
            child: Column(
              // Column for each category (Shades Row + Label)
              mainAxisSize:
                  MainAxisSize.min, // Column takes minimum vertical space
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align content to the bottom
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Center shades and label horizontally
              children: [
                // Horizontal Row of Shades
                Row(
                  // Row to arrange shades horizontally
                  children: shadesInCategory.map((shadeName) {
                    final shadeColor = _shades[shadeName] ??
                        Colors.grey; // Default to grey if color not found
                    final isSelected = _selectedShade == shadeName;

                    return RotatedBox(
                      // Rotate the shade container by 180 degrees
                      quarterTurns: 2,
                      child: GestureDetector(
                        onTap: () => _handleShadeTap(shadeName),
                        child: Container(
                          width: 45, // Adjusted width
                          height: 85, // Adjusted height
                          margin: const EdgeInsets.only(
                              right: 8.0), // Spacing between horizontal shades
                          decoration: BoxDecoration(
                            color: shadeColor,
                            // Apply different border radii for a more refined tooth-like shape
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.elliptical(
                                  15, 10), // Elliptical radius for top corners
                              topRight: Radius.elliptical(15, 10),
                              bottomLeft: Radius.elliptical(25,
                                  40), // More pronounced elliptical radius for bottom
                              bottomRight: Radius.elliptical(25, 40),
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? cyan400
                                  : Colors.grey
                                      .shade400, // Selected color from your code
                              width:
                                  isSelected ? 1 : .5, // Widths from your code
                            ),
                            boxShadow: [
                              // Add a subtle shadow
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: RotatedBox(
                              // Rotate the text back to its original orientation
                              quarterTurns: 2,
                              child: Text(
                                shadeName,
                                style: TextStyle(
                                  // Determine text color based on shade luminance for readability
                                  color: ui.Color.fromARGB(
                                                  255,
                                                  shadeColor.red,
                                                  shadeColor.green,
                                                  shadeColor.blue)
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black87
                                      : Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 13, // Slightly smaller font size
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                    height: 8.0), // Spacing between shades and category label
                // Category Label
                Container(
                  // Calculate width based on the number of shades and their width/spacing
                  width: (45 + 8) * shadesInCategory.length.toDouble() -
                      8, // (shade width + margin) * count - last margin
                  height: 30, // Fixed height for the category label
                  decoration: BoxDecoration(
                    // Create a linear gradient using the colors of the shades in this category
                    gradient: LinearGradient(
                      colors: categoryShadeColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    border: Border.all(color: Colors.blueGrey, width: .5),
                    borderRadius: BorderRadius.circular(
                        4.0), // Slightly rounded corners for the label
                  ),
                  child: Center(
                    // Center the text within the container
                    child: Text(
                      category,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // Determine text color based on the overall luminance of the gradient's colors
                        // This is a simplification; for better contrast, you might need more complex logic
                        color: categoryShadeColors.fold<double>(
                                        0,
                                        (sum, color) =>
                                            sum + color.computeLuminance()) /
                                    categoryShadeColors.length >
                                0.5
                            ? Colors.black87
                            : Colors.white,
                        fontSize:
                            16, // Slightly smaller font size for the group label
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
