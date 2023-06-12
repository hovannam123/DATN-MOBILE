class Category {
  int? id;
  String? name;
  bool? deleteFlag;

  Category({this.id, this.name, this.deleteFlag});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deleteFlag = json['delete_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['delete_flag'] = this.deleteFlag;
    return data;
  }
}
