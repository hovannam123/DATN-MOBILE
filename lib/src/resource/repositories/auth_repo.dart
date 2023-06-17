import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class AuthRepository {
  final BaseApi _baseApi = BaseApi();
  final StoreData _storeData = StoreData();
  Future<String> login(
      {required String email, required String password}) async {
    String url = "/login";
    Map<String, String> body = {'email': email, 'password': password};
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      final token = respond["token"];
      final user = respond["user"];
      _storeData.storeUser(User.fromJson(user));
      _storeData.storeToken(token);
      return token;
    } else {
      throw respond["message"];
    }
  }

  Future<String> signup(
      {required String email,
      required String password,
      required String phone_number}) async {
    String url = "/create-user";
    Map<String, String> body = {
      'email': email,
      'password': password,
      'phone_number': phone_number
    };
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond['statusCode'] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> forgetPassword({required String email}) async {
    String url = "/forget-password";

    Map<String, String> body = {
      'email': email,
    };
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond['statusCode'] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> verify({required String email, required String code}) async {
    String url = "/verify";

    Map<String, String> body = {'email': email, 'code': code};
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond['statusCode'] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> resetPassword(
      {required String email, required String password}) async {
    String url = "/reset-password";

    Map<String, String> body = {'email': email, 'password': password};
    var respond = await _baseApi.putMethod(url, body: body);
    if (respond['statusCode'] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }
}
