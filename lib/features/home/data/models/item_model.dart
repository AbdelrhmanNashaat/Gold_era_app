class Product {
  final String title;
  final String price;
  Product({required this.title, required this.price});
  factory Product.placeholder() {
    return Product(
      title: 'Quarter of a gram gold bar – 24 Karat',
      price: '2,128.14 EGP',
    );
  }

  @override
  String toString() => 'Product(title: $title, price: $price)';
}
