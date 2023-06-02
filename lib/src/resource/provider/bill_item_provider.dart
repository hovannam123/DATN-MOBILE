import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/model/bill.dart';
import 'package:safe_food/src/resource/model/bill_count.dart';

class BillProvider with ChangeNotifier {
  List<Bill> _listBill = [];
  List<Bill> _listBillPending = [];
  List<BillCount> _listBillCount = [];
  bool isLoad = false;

  get listBill => this._listBill;
  get listBillPending => this._listBillPending;
  get listBillCount => this._listBillCount;

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
}
