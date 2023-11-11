import 'dart:ffi';

import 'package:safe_food/src/resource/model/user_information.dart';

class User {
  int? id;
  String? email;
  String? password;
  String? phoneNumber;
  bool? active;
  int? roleId;
  UserInformation? userInformation;
  List<BillData>? billData;

  User(
      {this.id,
      this.email,
      this.password,
      this.phoneNumber,
      this.active,
      this.roleId,
      this.userInformation,
      this.billData});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phone_number'];
    active = json['active'];
    roleId = json['role_id'];
    userInformation = json['UserInformation'] != null
        ? new UserInformation.fromJson(json['UserInformation'])
        : null;
    if (json['bill_data'] != null) {
      billData = <BillData>[];
      json['bill_data'].forEach((v) {
        billData!.add(new BillData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone_number'] = this.phoneNumber;
    data['active'] = this.active;
    data['role_id'] = this.roleId;
    if (this.userInformation != null) {
      data['UserInformation'] = this.userInformation!.toJson();
    }
    if (this.billData != null) {
      data['bill_data'] = this.billData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillData {
  int? totalBill;
  String? totalPayment;

  BillData({this.totalBill, this.totalPayment});

  BillData.fromJson(Map<String, dynamic> json) {
    totalBill = json['total_bill'];
    totalPayment = json['total_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_bill'] = this.totalBill;
    data['total_payment'] = this.totalPayment;
    return data;
  }
}
