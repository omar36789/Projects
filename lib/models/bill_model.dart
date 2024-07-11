class BillModel {
  final String id;
  final String details;
  final String month;
  final double price;

  BillModel({
    required this.id,
    required this.details,
    required this.month,
    required this.price,
  });

  // Factory method to create a BillModel from a map
  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      id: map['id'] as String,
      details: map['details'] as String,
      month: map['month'] as String,
      price: map['price'] as double,
    );
  }

  // Method to convert BillModel to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'details': details,
      'month': month,
      'price': price,
    };
  }
}
