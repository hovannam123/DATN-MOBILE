import 'package:safe_food/src/resource/model/voucher.dart';

class UserVoucher {
  int? id;
  Voucher? voucher;

  UserVoucher({this.id, this.voucher});

  UserVoucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucher =
        json['Voucher'] != null ? new Voucher.fromJson(json['Voucher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.voucher != null) {
      data['Voucher'] = this.voucher!.toJson();
    }
    return data;
  }
}
