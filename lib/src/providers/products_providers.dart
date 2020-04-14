import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:form_validation_bloc/src/models/product_model.dart';

class ProductsProvider {
  final String _url = 'https://flutter-curso-udemy-28b08.firebaseio.com';

  Future<bool> addProduct(ProductModel product) async {
    final url = '$_url/products.json';

    final response = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);
    return true;
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json';

    final response = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> getAllProducts() async {
    final url = '$_url/products.json';
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductModel> products = new List();
    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      products.add(prodTemp);
    });

    return products;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    final response = await http.delete(url);

    print(json.decode(response.body));

    return 1;
  }
}
