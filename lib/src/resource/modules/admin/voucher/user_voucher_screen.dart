import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/bill_item.dart';
import 'package:safe_food/src/resource/model/user_voucher.dart';
import 'package:safe_food/src/resource/modules/admin/voucher/give_voucher_screen.dart';
import 'package:safe_food/src/resource/provider/bill_provider.dart';
import 'package:safe_food/src/resource/provider/voucher_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class UserVoucherScreen extends StatefulWidget {
  const UserVoucherScreen({super.key, required this.userId});
  final int? userId;

  @override
  State<UserVoucherScreen> createState() => _UserVoucherScreenState();
}

class _UserVoucherScreenState extends State<UserVoucherScreen> {
  int? _selectedCheckboxIndex;
  @override
  void initState() {
    Provider.of<VoucherProvider>(context, listen: false)
        .getUserVoucherInAd(widget.userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 240, 242, 247),
        ),
        child: Consumer<VoucherProvider>(
          builder: (context, voucherProvider, child) {
            final List<UserVoucher> listVoucher =
                voucherProvider.listUserVoucher;
            return voucherProvider.isLoad
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
                      title: const Text("User voucher",
                          style: AppTextStyle.heading2Black),
                    ),
                    body: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              listVoucher.isEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: 7, bottom: size.height / 1.5),
                                      child: const Text(
                                        'No discount',
                                        style: AppTextStyle.h_grey_no_underline,
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 7, left: 5),
                                          child: Text(
                                            'Voucher exist',
                                            style: AppTextStyle
                                                .h_grey_no_underline,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width,
                                          height: size.height / 1.5,
                                          child: ListView.builder(
                                            itemCount: listVoucher.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: size.width,
                                                height: 85,
                                                padding: EdgeInsets.all(5),
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white54,
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.7),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                7))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 15),
                                                          decoration: const BoxDecoration(
                                                              color: Colors
                                                                  .deepOrange,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          7))),
                                                          child: const Center(
                                                              child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .tags,
                                                                  size: 60)),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Giảm ${(listVoucher[index].voucher!.valuePercent! * 100).toInt()}%',
                                                              style: AppTextStyle
                                                                  .heading3Black,
                                                            ),
                                                            Text(
                                                              'Bắt đầu:  ${listVoucher[index].voucher!.startAt!.split('T')[0]}',
                                                              style: AppTextStyle
                                                                  .heading3Black,
                                                            ),
                                                            Text(
                                                              'Hết hạn: ${listVoucher[index].voucher!.endAt!.split('T')[0]}',
                                                              style: AppTextStyle
                                                                  .heading3Black,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Checkbox(
                                                      checkColor: Colors.white,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .deepOrange),
                                                      value:
                                                          _selectedCheckboxIndex ==
                                                              index,
                                                      shape: CircleBorder(),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          _selectedCheckboxIndex =
                                                              value!
                                                                  ? index
                                                                  : null;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GiveVoucherScreen(
                                                      userId: widget.userId,
                                                    )));
                                      },
                                      child: Container(
                                        width: size.width / 2 - 24,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: const Center(
                                            child: Text(
                                          'Give voucher',
                                          style: AppTextStyle.heading3Black,
                                        )),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        if (_selectedCheckboxIndex != null) {
                                          await voucherProvider
                                              .deleteVoucherUser(
                                                  widget.userId!,
                                                  listVoucher[
                                                          _selectedCheckboxIndex!]
                                                      .voucher!
                                                      .id!)
                                              .then(
                                                (message) => {
                                                  voucherProvider
                                                      .getUserVoucherInAd(
                                                          widget.userId!),
                                                  showSuccessDialog(
                                                      context, message),
                                                },
                                              )
                                              .catchError((error) => {
                                                    showErrorDialog(
                                                        context, error)
                                                  });
                                        } else {
                                          showSuccessDialog(context,
                                              'Please choose voucher code');
                                        }
                                      },
                                      child: Container(
                                        width: size.width / 2 - 24,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: const Center(
                                            child: Text(
                                          'Delete',
                                          style: AppTextStyle.heading3Black,
                                        )),
                                      ))
                                ],
                              )
                            ],
                          )),
                    ),
                  );
          },
        ));
  }
}
