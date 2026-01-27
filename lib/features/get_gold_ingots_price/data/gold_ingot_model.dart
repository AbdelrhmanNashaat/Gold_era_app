class GoldIngot {
  final int? id;
  final String title;
  final String price;

  GoldIngot({this.id, required this.title, required this.price});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'price': price};
  }

  factory GoldIngot.fromMap(Map<String, dynamic> map) {
    return GoldIngot(id: map['id'], title: map['title'], price: map['price']);
  }
}
