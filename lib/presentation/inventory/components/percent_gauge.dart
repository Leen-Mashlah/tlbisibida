import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget percentCircle(BuildContext context, Item item) {
  final quantity = item.quantity ?? 0;
  final standardQuantity = item.standardQuantity ?? 1;
  final minimumQuantity = item.minimumQuantity ?? 0;

  // Calculate percentage (cap at 100% if quantity exceeds standard)
  final percent =
      quantity / standardQuantity > 1 ? 1.0 : quantity / standardQuantity;

  // Determine color based on quantity levels
  Color progressColor;
  if (quantity <= minimumQuantity) {
    progressColor = Colors.redAccent; // Critical - below minimum
  } else if (quantity <= standardQuantity * 0.4) {
    progressColor = Colors.orange; // Low - below 40% of standard
  } else if (quantity <= standardQuantity) {
    progressColor = Colors.amber; // Below standard
  } else {
    progressColor = Colors.green; // Above standard - good
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircularPercentIndicator(
      radius: 75,
      lineWidth: 5,
      percent: percent,
      progressColor: progressColor,
      arcType: ArcType.HALF,
      arcBackgroundColor: cyan100,
      animation: true,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Container(
            height: 1.5,
            width: 50,
            color: Colors.black54,
            margin: const EdgeInsets.symmetric(vertical: 4),
          ),
          Text(
            standardQuantity.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          if (item.unit != null) ...[
            const SizedBox(height: 2),
            Text(
              item.unit!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
      animationDuration: 1500,
      curve: Curves.fastEaseInToSlowEaseOut,
      footer: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Text(
              item.name ?? 'Unknown Item',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: progressColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: progressColor.withOpacity(0.3)),
              ),
              child: Text(
                _getQuantityStatusText(
                    quantity, standardQuantity, minimumQuantity),
                style: TextStyle(
                  fontSize: 10,
                  color: progressColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

String _getQuantityStatusText(
    int quantity, int standardQuantity, int minimumQuantity) {
  if (quantity <= minimumQuantity) {
    return 'حرج';
  } else if (quantity <= standardQuantity * 0.4) {
    return 'منخفض';
  } else if (quantity <= standardQuantity) {
    return 'أقل من المعيار';
  } else {
    return 'جيد';
  }
}
