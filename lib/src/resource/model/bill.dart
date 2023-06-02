import 'package:safe_food/src/resource/model/user.dart';

class Bill {
  int? id;
  int? userId;
  String? totalOrigin;
  String? totalVoucher;
  String? totalPayment;
  String? status;
  String? createdAt;
  User? user;

  Bill(
      {this.id,
      this.userId,
      this.totalOrigin,
      this.totalVoucher,
      this.totalPayment,
      this.status,
      this.createdAt,
      this.user});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalOrigin = json['total_origin'];
    totalVoucher = json['total_voucher'];
    totalPayment = json['total_payment'];
    status = json['status'];
    createdAt = json['createdAt'];
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
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}
