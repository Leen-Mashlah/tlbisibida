import 'package:flutter/material.dart';
// Assuming this contains your color constants
import 'package:intl/intl.dart';
import 'package:lambda_dent_dash/constants/constants.dart'; // Import for number formatting

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.value, // Formatted value string
    this.count, // Optional count value
    required this.isSquare,
    this.size = 16,
    this.textColor, // This parameter seems unused in the original code, keeping for now
  });

  final Color color;
  final String value; // Formatted value string
  final String text; // The category text
  final double? count; // Optional count value
  final bool isSquare;
  final double size;
  final Color? textColor;

  // Helper to format the count if it exists
  String _formatCount(double count) {
    final formatter = NumberFormat(
        '#,##0', 'en_US'); // Use 'en_US' locale for comma separation
    return '(${formatter.format(count)})'; // Format and wrap in parentheses
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, // Increased width slightly to accommodate count
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min, // Use minimum size for the row
        children: <Widget>[
          // Color Square/Circle
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: isSquare ? BorderRadius.circular(5) : null,
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(
            width: 8, // Spacing after color box
          ),
          // Text (Category Name)
          Expanded(
            // Allow text to take available space
            flex: 2, // Give more flex to the text
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: cyan600, // Assuming cyan600 is defined in constants.dart
                overflow: TextOverflow.ellipsis, // Prevent overflow
              ),
              maxLines: 1, // Ensure single line
            ),
          ),
          // Count (Optional)
          if (count != null) // Only show count if it's provided
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0), // Add padding before count
              child: Text(
                _formatCount(count!), // Display formatted count
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14, // Slightly smaller font for count
                  fontWeight: FontWeight.normal,
                  color: cyan500, // Use a similar color as the value
                ),
                overflow: TextOverflow.ellipsis, // Prevent overflow
                maxLines: 1, // Ensure single line
              ),
            ),
          const SizedBox(
            width: 8, // Spacing before value
          ),
          // Value
          Text(
            value, // Display the formatted value
            style: TextStyle(
              color: cyan500, // Assuming cyan500 is defined in constants.dart
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
