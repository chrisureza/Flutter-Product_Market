import 'package:flutter/material.dart';
import 'package:form_validation_bloc/src/blocs/provider.dart';
import 'package:form_validation_bloc/src/models/product_model.dart';
import 'package:form_validation_bloc/src/providers/products_providers.dart';

class HomePage extends StatelessWidget {
  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: _listOfProducts(),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _listOfProducts() {
    return FutureBuilder(
      future: productsProvider.getAllProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) =>
                _productItem(context, products[index]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _productItem(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productsProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text('${product.title} - \$${product.price}'),
        subtitle: Text(product.id),
        onTap: () =>
            Navigator.pushNamed(context, 'product', arguments: product),
      ),
    );
  }
}
