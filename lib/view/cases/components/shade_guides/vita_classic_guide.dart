import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Import for ui.Color

// A widget that simulates a VITA classic shade guide with categories and
// shades arranged horizontally, with overall horizontal scrolling,
// category labels with gradients based on their shades, and rotated shade swatches.
// Updated to accept an initial selected shade and return both shade name and color on selection.
class VitaShadeGuide extends StatefulWidget {
  // Callback function that is called when a shade is selected.
  // Now returns both the shade name (String) and the shade color (Color).
  final Function(String shadeName, Color shadeColor)? onShadeSelected;

  // Optional initial selected shade name.
  final String? initialSelectedShade;

  const VitaShadeGuide({
    Key? key,
    this.onShadeSelected,
    this.initialSelectedShade, // Add the new parameter
  }) : super(key: key);

  @override
  _VitaShadeGuideState createState() => _VitaShadeGuideState();
}

class _VitaShadeGuideState extends State<VitaShadeGuide> {
  // The currently selected shade name.
  String? _selectedShade;

  // Define the VITA classic shades and their approximate colors,
  // visually estimated from the provided image.
  final Map<String, Color> _shades = {
    // Visually estimating colors from the uploaded image
    'A1': const Color(0xFFF8F5ED), // Lighter, slightly yellowish
    'A2': const Color(0xFFF5EEDA), // More yellow than A1
    'A3': const Color(0xFFF0E4C7), // Deeper yellow/light brown
    'A3.5': const Color(0xFFEAD8B0), // More saturated brown-yellow
    'A4': const Color(0xFFE0C99E), // Browner, darker

    'B1': const Color(0xFFFCF9F2), // Very light, slightly creamy
    'B2': const Color(0xFFF8F3E6), // Light creamy yellow
    'B3': const Color(
        0xFFF5EEDA), // Similar to A2, slightly different hue perhaps
    'B4': const Color(0xFFEEDFC5), // Light brown/tan

    'C1': const Color(0xFFE0E0DB), // Light greyish
    'C2': const Color(0xFFD3D3CD), // Medium greyish
    'C3': const Color(0xFFC0C0B8), // Darker greyish
    'C4': const Color(0xFFABA9A3), // Dark grey

    'D2': const Color(0xFFD8D4CC), // Greyish brown
    'D3': const Color(0xFFC5C0B8), // Darker greyish brown
    'D4': const Color(0xFFB0ABA3), // Darkest greyish brown
  };

  // Define the order of the shades for display, grouped by type.
  final Map<String, List<String>> _shadeOrder = {
    'A': ['A1', 'A2', 'A3', 'A3.5', 'A4'],
    'B': ['B1', 'B2', 'B3', 'B4'],
    'C': ['C1', 'C2', 'C3', 'C4'],
    'D': ['D2', 'D3', 'D4'],
  };

  @override
  void initState() {
    super.initState();
    // Initialize the selected shade with the provided initial value, if any.
    _selectedShade = widget.initialSelectedShade;
  }

  // Function to handle a shade being tapped.
  void _handleShadeTap(String shadeName) {
    setState(() {
      _selectedShade = shadeName;
    });
    // Get the color for the selected shade.
    final shadeColor = _shades[shadeName] ?? Colors.grey;
    // Call the user-provided callback with the selected shade name and color.
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
                              // Restored color and width changes
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
                      'Group $category',
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
