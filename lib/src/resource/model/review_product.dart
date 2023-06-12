import 'package:safe_food/src/resource/model/user.dart';

class ReviewProduct {
  int? id;
  int? productId;
  String? content;
  String? createdAt;
  User? user;

  ReviewProduct(
      {this.id, this.productId, this.content, this.createdAt, this.user});

  ReviewProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    content = json['content'];
    createdAt = json['createdAt'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}
