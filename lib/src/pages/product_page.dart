import 'package:flutter/material.dart';
import 'package:form_validation_bloc/src/models/product_model.dart';
import 'package:form_validation_bloc/src/providers/products_providers.dart';
import 'package:form_validation_bloc/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final productsProvider = new ProductsProvider();
  ProductModel product = new ProductModel();

  @override
  Widget build(BuildContext context) {
    final ProductModel prodArgs = ModalRoute.of(context).settings.arguments;
    if (prodArgs != null) {
      product = prodArgs;
    }

    return Container(
      child: Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: Text('Product'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
            IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  _nameField(),
                  _priceField(),
                  _availableField(context),
                  _saveBotton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product name',
      ),
      onSaved: (value) => product.title = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Name should be longer';
        }
        return null;
      },
    );
  }

  Widget _priceField() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      //The onSaved function is called after the validator is applied so at this point we are sure that the value is a number because od the utils.isNumber function
      onSaved: (value) => product.price = double.parse(value),
      validator: (value) {
        if (utils.isNumber(value)) {
          return null;
        }
        return 'Price has to be a number';
      },
    );
  }

  Widget _availableField(BuildContext context) {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value) => setState(() {
        product.available = value;
      }),
    );
  }

  Widget _saveBotton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: _submit,
    );
  }

  void _submit() {
    // Is not a valid form then escape the function
    if (!formkey.currentState.validate()) return;

    //This line trigger the onSave Methods for all the fields into the form
    formkey.currentState.save();

    print('All OK');
    print(product.title);
    print(product.price);
    print(product.available);

    if (product.id == null) {
      productsProvider.addProduct(product);
    } else {
      productsProvider.editProduct(product);
    }

    showSnackbar('Product Saved.');
  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
      // behavior: SnackBarBehavior.floating,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      // backgroundColor: Colors.grey[600],
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
