import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Import for ui.Color

// Widget for the VITA 3D Master Shade Guide.
// This widget simulates the behavior needed for integration into the
// ShadeSelectionButton's modal sheet, with shades and layout based on VITA 3D Master.
class Vita3DMasterGuide extends StatefulWidget {
  // Callback function that is called when a shade is selected.
  // Returns both the shade name (String) and the shade color (Color).
  final Function(String shadeName, Color shadeColor)? onShadeSelected;

  // Optional initial selected shade name.
  final String? initialSelectedShade;

  const Vita3DMasterGuide({
    Key? key,
    this.onShadeSelected,
    this.initialSelectedShade,
  }) : super(key: key);

  @override
  _Vita3DMasterGuideState createState() => _Vita3DMasterGuideState();
}

class _Vita3DMasterGuideState extends State<Vita3DMasterGuide> {
  // Define the VITA 3D Master shades and their approximate colors.
  // Note: These colors are approximations.
  final Map<String, Color> _shades = {
    // Value 0
    '0M1': const Color(0xFFF5F5F0), // Very light
    '0M2': const Color(0xFFF0F0E8), // Slightly less light

    // Value 1
    '1M1': const Color(0xFFF8F8F0), // Very light, slightly yellowish
    '1M2': const Color(0xFFF5F5E8), // Slightly less light, slightly yellowish

    // Value 2
    '2L1.5': const Color(0xFFF0F0D8), // Light, yellowish
    '2M1': const Color(0xFFF0E8D0), // Medium, yellowish
    '2M2': const Color(0xFFE8E0C8), // Medium, more saturated yellowish
    '2R1.5': const Color(0xFFE8D8C0), // Light reddish-yellowish
    '2R2.5': const Color(0xFFE0D0B8), // Medium reddish-yellowish

    // Value 3
    '3L1.5': const Color(0xFFE0D8B0), // Medium, yellowish-brown
    '3M1': const Color(0xFFD8C8A8), // Medium, more saturated yellowish-brown
    '3M2': const Color(0xFFD0C0A0), // Medium-dark, yellowish-brown
    '3M3': const Color(0xFFC8B898), // Darker, yellowish-brown
    '3R2.5': const Color(0xFFC0A888), // Medium-dark reddish-brown

    // Value 4
    '4L1.5': const Color(0xFFB8A880), // Dark, yellowish-brown
    '4M1': const Color(0xFFB0A078), // Dark, more saturated yellowish-brown
    '4M2': const Color(0xFFA89870), // Darker, yellowish-brown
    '4M3': const Color(0xFFA09068), // Darkest, yellowish-brown
    '4R2.5': const Color(0xFF988860), // Dark reddish-brown

    // Value 5
    '5M1': const Color(0xFF908058), // Very dark, yellowish-brown
    '5M2': const Color(0xFF887850), // Very dark, more saturated yellowish-brown
    '5M3': const Color(0xFF807048), // Very dark, darkest yellowish-brown
  };

  // Define the order of the shades for display, grouped by Value and Chroma/Hue.
  // This is a simplified representation of the 3D Master structure.
  final Map<String, List<String>> _shadeOrder = {
    'Value 0': ['0M1', '0M2'],
    'Value 1': ['1M1', '1M2'],
    'Value 2': ['2L1.5', '2M1', '2M2', '2R1.5', '2R2.5'],
    'Value 3': ['3L1.5', '3M1', '3M2', '3M3', '3R2.5'],
    'Value 4': ['4L1.5', '4M1', '4M2', '4M3', '4R2.5'],
    'Value 5': ['5M1', '5M2', '5M3'],
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
