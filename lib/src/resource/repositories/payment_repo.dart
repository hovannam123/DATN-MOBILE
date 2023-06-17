import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class PaymentRepository {
  final BaseApi _baseApi = BaseApi();

  Future<String> createPayment(int userId) async {
    String url = "/payment?user_id=$userId";
    var respond = await _baseApi.postMethod(url);

    if (respond["statusCode"] == 200) {
      return respond["url"];
    } else {
      throw respond['message'];
    }
  }
}
