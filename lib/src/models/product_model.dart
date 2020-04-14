import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String title;
  double price;
  bool available;
  String photoUrl;

  ProductModel({
    this.id,
    this.title = '',
    this.price = 0.0,
    this.available = true,
    this.photoUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        available: json["available"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "title": title,
        "price": price,
        "available": available,
        "photoUrl": photoUrl,
      };
}
