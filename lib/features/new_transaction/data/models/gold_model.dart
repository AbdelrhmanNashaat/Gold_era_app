class GoldTransaction {
  final int? id;
  final String weight;
  final String buyPrice;
  final String date;

  GoldTransaction({
    this.id,
    required this.weight,
    required this.buyPrice,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': weight, 'buy_price': buyPrice, 'date': date};
  }

  factory GoldTransaction.fromMap(Map<String, dynamic> map) {
    return GoldTransaction(
      id: map['id'],
      weight: map['name'],
      buyPrice: map['buy_price'],
      date: map['date'],
    );
  }
}
