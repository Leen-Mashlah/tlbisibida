class LabItemHistory {
  final int id;
  final int itemId;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String createdAt;
  final int itemInnerId;
  final String itemName;

  LabItemHistory({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.itemInnerId,
    required this.itemName,
  });
}
