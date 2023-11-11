import 'package:safe_food/src/resource/model/size.dart';
import 'package:safe_food/src/resource/model/user_voucher.dart';
import 'package:safe_food/src/resource/model/voucher.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class VoucherRepository {
  final BaseApi _baseApi = BaseApi();

  Future<List<UserVoucher>> getUserVoucher(int userId) async {
    String url = "/all-voucher-user?user_id=$userId";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => UserVoucher.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<List<Voucher>> getAllVoucher() async {
    String url = "/all-voucher";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => Voucher.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<String> createVoucher(
      String valuePercent, String startAt, String endAt) async {
    String url = "/create-voucher";
    Map<String, dynamic> body = {
      "value_percent": valuePercent,
      "start_at": startAt,
      "end_at": endAt
    };
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> createVoucherUser(int userId, int voucherId) async {
    String url = "/create-voucher-user";
    Map<String, dynamic> body = {"user_id": userId, "voucher_id": voucherId};
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> deleteVoucherUser(int userId, int voucherId) async {
    String url = "/delete-voucher-user";
    Map<String, dynamic> body = {"user_id": userId, "voucher_id": voucherId};
    var respond = await _baseApi.deleteMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> deleteVoucher(int voucherId) async {
    String url = "/delete-voucher";
    Map<String, dynamic> body = {"voucher_id": voucherId};
    var respond = await _baseApi.deleteMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }
}
