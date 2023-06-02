class BillCount {
  DateTime? date;
  int? count;

  BillCount({this.date, this.count});

  BillCount.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['createdAt']);
    count = json['count'];
  }
}
