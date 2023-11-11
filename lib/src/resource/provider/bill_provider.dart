import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/model/bill.dart';
import 'package:safe_food/src/resource/model/bill_chart.dart';
import 'package:safe_food/src/resource/model/bill_item.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/repositories/bill_repo.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

class BillProvider with ChangeNotifier {
  final BillRepository _billRepository = BillRepository();
  List<Bill> _listBill = [];
  // List<Bill> _listBillPending = [];
  List<BillChart> _listBillCount = [];
  List<BillItem> _listBillItem = [];
  bool isLoad = false;

  get listBill => this._listBill;
  // get listBillPending => this._listBillPending;
  get listBillCount => this._listBillCount;
  get listBillItem => this._listBillItem;

  void getListBill() async {
    isLoad = true;
    _listBill = await _billRepository.getListBill();
    isLoad = false;
    notifyListeners();
  }

  void getListBillPending() async {
    isLoad = true;
    // _listBillPending = await _billRepository.getListBillPending();
    isLoad = false;
    notifyListeners();
  }

  void getListBillCount() async {
    isLoad = true;
    _listBillCount = await _billRepository.getListBillCount();
    isLoad = false;
    notifyListeners();
  }

  void getListBillItem() async {
    isLoad = true;
    _listBillItem = await _billRepository.getListBillItem();
    isLoad = false;
    notifyListeners();
  }

  void getListBillItemUser() async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    _listBillItem = await _billRepository.getListBillItemUser(user.id!);
    isLoad = false;
    notifyListeners();
  }

  void getListBillItemUserInAd(int userId) async {
    isLoad = true;
    _listBillItem = await _billRepository.getListBillItemUser(userId);
    isLoad = false;
    notifyListeners();
  }

  void getListBillItemPending() async {
    isLoad = true;
    _listBillItem = await _billRepository.getListBillItemPending();
    isLoad = false;
    notifyListeners();
  }

  Future<String> verifyOrder(int billId) async {
    isLoad = true;
    String message = await _billRepository.verifyOrder(billId);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> verifyAllOrder() async {
    isLoad = true;
    String message = await _billRepository.verifyAllOrder();
    isLoad = false;
    notifyListeners();
    return message;
  }
}
