import 'package:safe_food/src/resource/model/category.dart';
import 'package:safe_food/src/resource/model/size.dart';

class ProductDetail {
  int? id;
  String? name;
  String? imageOrigin;
  String? description;
  String? price;
  bool? status;
  bool? deleteFlag;
  Category? category;
  List<SizeData>? sizeData;

  ProductDetail(
      {this.id,
      this.name,
      this.imageOrigin,
      this.description,
      this.price,
      this.status,
      this.deleteFlag,
      this.category,
      this.sizeData});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageOrigin = json['image_origin'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    deleteFlag = json['delete_flag'];
    category = json['Category'] != null
        ? new Category.fromJson(json['Category'])
        : null;
    if (json['size_data'] != null) {
      sizeData = <SizeData>[];
      json['size_data'].forEach((v) {
        sizeData!.add(new SizeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_origin'] = this.imageOrigin;
    data['description'] = this.description;
    data['price'] = this.price;
    data['status'] = this.status;
    data['delete_flag'] = this.deleteFlag;
    if (this.category != null) {
      data['Category'] = this.category!.toJson();
    }
    if (this.sizeData != null) {
      data['size_data'] = this.sizeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SizeData {
  int? amount;
  int? id;
  Size? size;

  SizeData({this.amount, this.id, this.size});

  SizeData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    id = json['id'];
    size = json['Size'] != null ? new Size.fromJson(json['Size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['id'] = this.id;
    if (this.size != null) {
      data['Size'] = this.size!.toJson();
    }
    return data;
  }
}
