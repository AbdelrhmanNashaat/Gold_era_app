class GoldTransaction {
  final int? id;
  final double grams;
  final double buyPrice;
  final String date;

  GoldTransaction({
    this.id,
    required this.grams,
    required this.buyPrice,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'grams': grams, 'buy_price': buyPrice, 'date': date};
  }

  factory GoldTransaction.fromMap(Map<String, dynamic> map) {
    return GoldTransaction(
      id: map['id'],
      grams: (map['grams'] as num).toDouble(),
      buyPrice: (map['buy_price'] as num).toDouble(),
      date: map['date'],
    );
  }
}
