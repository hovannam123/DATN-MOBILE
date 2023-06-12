class BillChart {
  DateTime? date;
  int? count;
  String? totalPayment;

  BillChart({this.date, this.count, this.totalPayment});

  BillChart.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    count = json['count'];
    totalPayment = json['total_payment'];
  }
}
