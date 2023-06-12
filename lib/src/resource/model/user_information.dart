class UserInformation {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  bool? gender;
  String? birthday;
  String? userImage;

  UserInformation(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.gender,
      this.birthday,
      this.userImage});

  UserInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    birthday = json['birthday'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['user_image'] = this.userImage;
    return data;
  }
}
