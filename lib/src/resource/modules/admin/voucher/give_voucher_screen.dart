import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/voucher.dart';
import 'package:safe_food/src/resource/modules/admin/voucher/create_voucher_screen.dart';
import 'package:safe_food/src/resource/provider/voucher_provider.dart';

import '../../../utils/enums/helpers.dart';

class GiveVoucherScreen extends StatefulWidget {
  const GiveVoucherScreen({super.key, required this.userId});
  final int? userId;

  @override
  State<GiveVoucherScreen> createState() => _GiveVoucherScreenState();
}

class _GiveVoucherScreenState extends State<GiveVoucherScreen> {
  int? _selectedCheckboxIndex;
  @override
  void initState() {
    Provider.of<VoucherProvider>(context, listen: false).getAllVoucher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final voucherProvider = Provider.of<VoucherProvider>(context);

    final List<Voucher> listVoucher = voucherProvider.listVoucher;
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 240, 242, 247),
        ),
        child: voucherProvider.isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: const Text("Give voucher",
                      style: AppTextStyle.heading2Black),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Mã giảm giá',
                          style: AppTextStyle.heading3Black,
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height / 1.7,
                        child: ListView.builder(
                          itemCount: listVoucher.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: size.width,
                              height: 85,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  border: Border.all(
                                      color: Colors.grey, width: 0.7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: const BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7))),
                                        child: const Center(
                                            child: FaIcon(FontAwesomeIcons.tags,
                                                size: 60)),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Giảm ${(listVoucher[index].valuePercent! * 100).toInt()}%',
                                            style: AppTextStyle.heading3Black,
                                          ),
                                          Text(
                                            'Bắt đầu:  ${listVoucher[index].startAt!.split('T')[0]}',
                                            style: AppTextStyle.heading3Black,
                                          ),
                                          Text(
                                            'Hết hạn: ${listVoucher[index].endAt!.split('T')[0]}',
                                            style: AppTextStyle.heading3Black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.all(
                                        Colors.deepOrange),
                                    value: _selectedCheckboxIndex == index,
                                    shape: CircleBorder(),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _selectedCheckboxIndex =
                                            value! ? index : null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () async {
                                if (_selectedCheckboxIndex != null) {
                                  await voucherProvider
                                      .createVoucherUser(
                                          widget.userId!,
                                          listVoucher[_selectedCheckboxIndex!]
                                              .id!)
                                      .then(
                                        (message) => {
                                          voucherProvider.getUserVoucherInAd(
                                              widget.userId!),
                                          showSuccessDialog(context, message),
                                          Navigator.pop(context)
                                        },
                                      )
                                      .catchError((error) =>
                                          {showErrorDialog(context, error)});
                                } else {
                                  showSuccessDialog(
                                      context, 'Please choose voucher code');
                                }
                              },
                              child: Container(
                                width: size.width / 2 - 16,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    'Give',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                ),
                              )),
                          TextButton(
                              onPressed: () async {
                                if (_selectedCheckboxIndex != null) {
                                  await voucherProvider
                                      .deleteVoucher(
                                          listVoucher[_selectedCheckboxIndex!]
                                              .id!)
                                      .then(
                                        (message) => {
                                          voucherProvider.getUserVoucherInAd(
                                              widget.userId!),
                                          voucherProvider.getAllVoucher(),
                                          showSuccessDialog(context, message),
                                        },
                                      )
                                      .catchError((error) =>
                                          {showErrorDialog(context, error)});
                                } else {
                                  showSuccessDialog(
                                      context, 'Please choose voucher code');
                                }
                              },
                              child: Container(
                                width: size.width / 2 - 16,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    'Delete',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateVoucherScreen()));
                          },
                          child: Container(
                            width: size.width - 20,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                'Create voucher',
                                style: AppTextStyle.heading3Black,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ));
  }
}
