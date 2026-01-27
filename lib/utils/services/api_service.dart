import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import '../../features/home/data/models/item_model.dart';

class ApiService {
  final Dio _dio = Dio();

  /// Fetch products from the website and return structured data
  Future<List<Product>> getGoldIngotProducts() async {
    final response = await _dio.get(
      'https://egypt.gold-era.com/product-category/ingots/?layout=grid',
    );

    if (response.statusCode == 200) {
      final htmlContent = response.data as String;
      Document document = parse(htmlContent);

      final elements = document.getElementsByClassName('product-caption');

      List<Product> products = [];

      for (var element in elements) {
        // Product title
        final titleElement = element.querySelector(
          '.woocommerce-loop-product__title a',
        );
        final title = titleElement?.text.trim() ?? '';

        // Product price
        final priceElement = element.querySelector(
          '.price .woocommerce-Price-amount',
        );
        final price = priceElement?.text.trim().replaceAll('\u00a0', ' ') ?? '';

        products.add(Product(title: title, price: price));
      }

      log('Found ${products.length} products');

      return products;
    } else {
      throw Exception(
        'Failed to load data from the API. Status code: ${response.statusCode}',
      );
    }
  }
}
