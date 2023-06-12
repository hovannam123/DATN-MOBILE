import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/model/bill.dart';
import 'package:safe_food/src/resource/model/bill_chart.dart';
import 'package:safe_food/src/resource/model/bill_item.dart';

class BillProvider with ChangeNotifier {
  List<Bill> _listBill = [];
  List<Bill> _listBillPending = [];
  List<BillChart> _listBillCount = [];
  List<BillItem> _listBillItem = [];
  bool isLoad = false;

  get listBill => this._listBill;
  get listBillPending => this._listBillPending;
  get listBillCount => this._listBillCount;
  get listBillItem => this._listBillItem;

  void getListBill() async {
    isLoad = true;
    _listBill = await ApiRequest.instance.getAllBill();
    isLoad = false;
    notifyListeners();
  }

  void getListBillPending() async {
    isLoad = true;
    _listBillPending = await ApiRequest.instance.getAllBillPending();
    isLoad = false;
    notifyListeners();
  }

  void getListBillCount() async {
    isLoad = true;
    _listBillCount = await ApiRequest.instance.getBillCount();
    isLoad = false;
    notifyListeners();
  }

  void getListBillItem() async {
    isLoad = true;
    _listBillItem = await ApiRequest.instance.getBillItem();
    isLoad = false;
    notifyListeners();
  }

  void getListBillItemPending() async {
    isLoad = true;
    _listBillItem = await ApiRequest.instance.getBillItemPending();
    isLoad = false;
    notifyListeners();
  }

  Future<String> verifyOrder(int bill_id) async {
    isLoad = true;
    String message = await ApiRequest.instance.verifyOrder(bill_id);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> verifyAllOrder() async {
    isLoad = true;
    String message = await ApiRequest.instance.verifyAllOrder();
    isLoad = false;
    notifyListeners();
    return message;
  }
}
