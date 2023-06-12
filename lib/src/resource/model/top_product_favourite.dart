import 'package:safe_food/src/resource/model/product.dart';

class TopProductFavourite {
  int? totalFavourite;
  Product? product;

  TopProductFavourite({this.totalFavourite, this.product});

  TopProductFavourite.fromJson(Map<String, dynamic> json) {
    totalFavourite = json['total_favourite'];
    product =
        json['Product'] != null ? new Product.fromJson(json['Product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_favourite'] = this.totalFavourite;
    if (this.product != null) {
      data['Product'] = this.product!.toJson();
    }
    return data;
  }
}
