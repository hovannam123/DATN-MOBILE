import 'package:safe_food/src/resource/model/user_information.dart';

class User {
  int? id;
  String? email;
  String? password;
  String? phoneNumber;
  bool? active;
  int? roleId;
  UserInformation? userInformation;

  User(
      {this.id,
      this.email,
      this.password,
      this.phoneNumber,
      this.active,
      this.roleId,
      this.userInformation});

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
    return data;
  }
}
