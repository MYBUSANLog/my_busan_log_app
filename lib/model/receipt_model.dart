class ReceiptModel {
  final String imageUrl;
  final String title;
  final double amount;
  final DateTime date;
  final String paymentStatus;
  final String paymentMethod;
  final String orderId;
  final String travelSchedule;
  final String travelLocation;

  ReceiptModel({
    required this.imageUrl,
    required this.title,
    required this.amount,
    required this.date,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderId,
    required this.travelSchedule,
    required this.travelLocation,
  });
}
