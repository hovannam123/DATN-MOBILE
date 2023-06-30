import 'package:safe_food/src/resource/model/size.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class SizeRepository {
  final BaseApi _baseApi = BaseApi();

  Future<List<Size>> getListSize() async {
    String url = "/all-size";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => Size.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<String> createSize(
      String sizeName, String weigh, String height) async {
    String url = "/create-size";
    Map<String, dynamic> body = {
      "size_name": sizeName,
      "weigh": weigh,
      "height": height
    };
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> updateSize(sizeId, String weigh, String height) async {
    String url = "/update-size?id=$sizeId";
    Map<String, dynamic> body = {"weigh": weigh, "height": height};
    var respond = await _baseApi.putMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }
}
