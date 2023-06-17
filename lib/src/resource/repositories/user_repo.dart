import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/model/user_information.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class UserRepository {
  final BaseApi _baseApi = BaseApi();

  Future<List<User>> getListUser() async {
    String url = "/all-user";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => User.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<User> getUserDetail(int userId) async {
    String url = "/get-user-detail?id=$userId";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return User.fromJson(respond["data"]);
    } else {
      throw respond["message"];
    }
  }

  Future<String> updateUserInformation(int userId, String firstName,
      String lastName, bool gender, String birthday) async {
    String url = "/update-user?id=$userId";
    Map<String, dynamic> body = {
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender,
      "birthday": birthday
    };

    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond["message"];
    }
  }
}
