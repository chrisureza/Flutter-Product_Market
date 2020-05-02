import 'dart:io';

import 'package:form_validation_bloc/src/providers/products_providers.dart';
import 'package:rxdart/rxdart.dart';

import 'package:form_validation_bloc/src/models/product_model.dart';

class ProductsBloc {
  final _productsController = new BehaviorSubject<List<ProductModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _productsProvider = new ProductsProvider();

  Stream<List<ProductModel>> get productsStream => _productsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  void getAllProducts() async {
    final products = await _productsProvider.getAllProducts();
    _productsController.sink.add(products);
  }

  void addProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productsProvider.addProduct(product);
    _loadingController.sink.add(false);
  }

  Future<String> uploadImg(File img) async {
    _loadingController.sink.add(true);
    final imgUrl = await _productsProvider.uploadImg(img);
    _loadingController.sink.add(false);

    return imgUrl;
  }

  void editProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productsProvider.editProduct(product);
    _loadingController.sink.add(false);
  }

  void deleteProduct(String id) async {
    await _productsProvider.deleteProduct(id);
  }

  dispose() {
    _productsController?.close();
    _loadingController?.close();
  }
}
