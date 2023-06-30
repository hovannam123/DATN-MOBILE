import 'package:flutter/cupertino.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/model/user_voucher.dart';
import 'package:safe_food/src/resource/model/voucher.dart';
import 'package:safe_food/src/resource/repositories/voucher_repo.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

class VoucherProvider with ChangeNotifier {
  final VoucherRepository _voucherRepository = VoucherRepository();
  List<UserVoucher> _listUserVoucher = [];
  List<Voucher> _listVoucher = [];
  UserVoucher? _userVoucher;
  bool isLoad = false;

  get listUserVoucher => this._listUserVoucher;
  get listVoucher => this._listVoucher;
  get userVoucher => this._userVoucher;

  void getUserVoucher() async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    _listUserVoucher = await _voucherRepository.getUserVoucher(user.id!);
    isLoad = false;
    notifyListeners();
  }

  void getUserVoucherInAd(int userId) async {
    isLoad = true;
    _listUserVoucher = await _voucherRepository.getUserVoucher(userId);
    isLoad = false;
    notifyListeners();
  }

  void getAllVoucher() async {
    isLoad = true;
    _listVoucher = await _voucherRepository.getAllVoucher();
    isLoad = false;
    notifyListeners();
  }

  Future<String> createVoucherUser(int userId, int voucherId) async {
    isLoad = true;
    String message =
        await _voucherRepository.createVoucherUser(userId, voucherId);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> deleteVoucherUser(int userId, int voucherId) async {
    isLoad = true;
    String message =
        await _voucherRepository.deleteVoucherUser(userId, voucherId);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> deleteVoucher(int voucherId) async {
    isLoad = true;
    String message = await _voucherRepository.deleteVoucher(voucherId);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> createVoucher(
      String valuePercent, String startAt, String endAt) async {
    isLoad = true;
    String message =
        await _voucherRepository.createVoucher(valuePercent, startAt, endAt);
    isLoad = false;
    notifyListeners();
    return message;
  }

  void selectVoucher(UserVoucher? newVoucher) {
    _userVoucher = newVoucher;
    notifyListeners();
  }

  void unselectVoucher() {
    _userVoucher = null;
    notifyListeners();
  }
}
