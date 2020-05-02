import 'dart:convert';
import 'dart:io';
import 'package:form_validation_bloc/src/user_preferences/user_preferences.dart';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:form_validation_bloc/src/models/product_model.dart';
import 'package:mime_type/mime_type.dart';

class ProductsProvider {
  final String _url = 'https://flutter-curso-udemy-28b08.firebaseio.com';
  final _prefs = new UserPreferences();

  Future<bool> addProduct(ProductModel product) async {
    final url = '$_url/products.json?auth=${_prefs.token}';

    final response = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);
    return true;
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json?auth=${_prefs.token}';

    final response = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> getAllProducts() async {
    final url = '$_url/products.json?auth=${_prefs.token}';
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductModel> products = new List();
    if (decodedData == null) return [];

    if (decodedData['error'] != null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      products.add(prodTemp);
    });

    return products;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json?auth=${_prefs.token}';
    final response = await http.delete(url);

    print(json.decode(response.body));

    return 1;
  }

  Future<String> uploadImg(File img) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dsvmtijoe/image/upload?upload_preset=z6rmgt4k');
    final mimeType = mime(img.path).split('/');
    final imgUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      img.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imgUploadRequest.files.add(file);

    final streamResponse = await imgUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Someting went wrong');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);

    print('respData:');
    print(respData);

    return respData['secure_url'];
  }
}
