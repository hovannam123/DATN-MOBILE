class Size {
  int? id;
  String? sizeName;
  String? weigh;
  String? height;

  Size({this.id, this.sizeName, this.weigh, this.height});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeName = json['size_name'];
    weigh = json['weigh'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size_name'] = this.sizeName;
    data['weigh'] = this.weigh;
    data['height'] = this.height;
    return data;
  }
}
