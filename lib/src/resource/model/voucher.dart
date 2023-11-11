class Voucher {
  int? id;
  double? valuePercent;
  String? startAt;
  String? endAt;

  Voucher({this.id, this.valuePercent, this.startAt, this.endAt});

  Voucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valuePercent = json['value_percent'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value_percent'] = this.valuePercent;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    return data;
  }
}
