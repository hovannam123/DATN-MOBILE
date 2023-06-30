import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class PaymentRepository {
  final BaseApi _baseApi = BaseApi();

  Future<String> createPayment({int? userVoucher}) async {
    User? user = await StoreData().retrieveUser();
    String url = "/payment?user_id=${user.id}";
    Map<String, dynamic> body = {};
    if (userVoucher != null) {
      body.addAll({"voucher_user_id": userVoucher});
    }
    var respond = await _baseApi.postMethod(url, body: body);

    if (respond["statusCode"] == 200) {
      return respond["url"];
    } else {
      throw respond['message'];
    }
  }
}
