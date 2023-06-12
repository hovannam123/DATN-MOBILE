import 'package:safe_food/src/resource/model/category.dart';

class Product {
  int? id;
  int? categoryId;
  String? name;
  String? imageOrigin;
  String? description;
  String? price;
  bool? status;
  bool? deleteFlag;
  Category? category;

  Product(
      {this.id,
      this.categoryId,
      this.name,
      this.imageOrigin,
      this.description,
      this.price,
      this.status,
      this.deleteFlag,
      this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    imageOrigin = json['image_origin'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    deleteFlag = json['delete_flag'];
    category = json['Category'] != null
        ? new Category.fromJson(json['Category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['image_origin'] = this.imageOrigin;
    data['description'] = this.description;
    data['price'] = this.price;
    data['status'] = this.status;
    data['delete_flag'] = this.deleteFlag;
    if (this.category != null) {
      data['Category'] = this.category!.toJson();
    }
    return data;
  }
}
