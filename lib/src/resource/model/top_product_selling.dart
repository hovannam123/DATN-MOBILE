import 'package:safe_food/src/resource/model/product.dart';

class TopProductSelling {
  String? totalQuantity;
  Product? product;

  TopProductSelling({this.totalQuantity, this.product});

  TopProductSelling.fromJson(Map<String, dynamic> json) {
    totalQuantity = json['total_quantity'];
    product = json['ProductSize']['Product'] != null
        ? new Product.fromJson(json['ProductSize']['Product'])
        : null;
  }
}
