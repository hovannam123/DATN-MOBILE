import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/model/size.dart';
import 'package:safe_food/src/resource/model/user.dart';

class BillItem {
  int? id;
  int? userId;
  String? totalOrigin;
  String? totalVoucher;
  String? totalPayment;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BillItems>? billItems;
  User? user;

  BillItem(
      {this.id,
      this.userId,
      this.totalOrigin,
      this.totalVoucher,
      this.totalPayment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.billItems,
      this.user});

  BillItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalOrigin = json['total_origin'];
    totalVoucher = json['total_voucher'];
    totalPayment = json['total_payment'];
    status = json['status'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    if (json['BillItems'] != null) {
      billItems = <BillItems>[];
      json['BillItems'].forEach((v) {
        billItems!.add(new BillItems.fromJson(v));
      });
    }
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['total_origin'] = this.totalOrigin;
    data['total_voucher'] = this.totalVoucher;
    data['total_payment'] = this.totalPayment;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.billItems != null) {
      data['BillItems'] = this.billItems!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}

class BillItems {
  int? id;
  int? billId;
  int? quantity;
  Product? product;
  Size? size;

  BillItems({
    this.id,
    this.billId,
    this.quantity,
    this.product,
    this.size,
  });

  BillItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billId = json['bill_id'];
    quantity = json['quantity'];
    product = json["ProductSize"]['Product'] != null
        ? new Product.fromJson(json["ProductSize"]["Product"])
        : null;
    size = json["ProductSize"]['Size'] != null
        ? new Size.fromJson(json["ProductSize"]["Size"])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_id'] = this.billId;
    if (this.product != null) {
      data['Product'] = this.product!.toJson();
    }
    if (this.size != null) {
      data['Size'] = this.size!.toJson();
    }
    return data;
  }
}
