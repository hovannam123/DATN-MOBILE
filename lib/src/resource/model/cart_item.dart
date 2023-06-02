
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/model/size.dart';

class CartItem {
  int? id;
  int? quantity;
  String? total;
  String? note;
  Product? product;
  Size? size;

  CartItem({
    this.id,
    this.quantity,
    this.total,
    this.note,
    this.product,
    this.size,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    total = json['total'];
    note = json['note'];
    product = json["product_size"]['Product'] != null
        ? new Product.fromJson(json["product_size"]["Product"])
        : null;
    size = json["product_size"]['Size'] != null
        ? new Size.fromJson(json["product_size"]["Size"])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['note'] = this.note;
    if (this.product != null) {
      data['Product'] = this.product!.toJson();
    }
    if (this.size != null) {
      data['Size'] = this.size!.toJson();
    }
    return data;
  }
}
