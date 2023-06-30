import 'package:safe_food/src/resource/model/bill.dart';
import 'package:safe_food/src/resource/model/bill_chart.dart';
import 'package:safe_food/src/resource/model/bill_item.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class BillRepository {
  final BaseApi _baseApi = BaseApi();

  Future<List<Bill>> getListBill() async {
    String url = "/all-bill";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => Bill.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  // Future<List<Bill>> getListBillPending() async {
  //   String url = "/all-bill-pending";
  //   var respond = await _baseApi.getMethod(url);
  //   if (respond["statusCode"] == 200) {
  //     return (respond["data"] as List)
  //         .map((json) => Bill.fromJson(json))
  //         .toList();
  //   } else {
  //     throw respond["message"];
  //   }
  // }

  Future<List<BillChart>> getListBillCount() async {
    String url = "/bill-count";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => BillChart.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<List<BillItem>> getListBillItem() async {
    String url = "/all-bill-item";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => BillItem.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<List<BillItem>> getListBillItemUser(int userId) async {
    String url = "/all-bill-item-user?user_id=$userId";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => BillItem.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<List<BillItem>> getListBillItemPending() async {
    String url = "/all-bill-item-pending";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => BillItem.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<String> verifyOrder(int billId) async {
    String url = "/verify-order";
    Map<String, dynamic> body = {"id": billId};

    var respond = await _baseApi.putMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond["message"];
    }
  }

  Future<String> verifyAllOrder() async {
    String url = "/verify-all-order";
    var respond = await _baseApi.putMethod(url);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond["message"];
    }
  }
}
