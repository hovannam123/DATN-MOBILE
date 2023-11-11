import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/user_voucher.dart';
import 'package:safe_food/src/resource/model/voucher.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';
import 'package:safe_food/src/resource/provider/voucher_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  int? _selectedCheckboxIndex;

  @override
  void initState() {
    Provider.of<VoucherProvider>(context, listen: false).getUserVoucher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final voucherProvide = Provider.of<VoucherProvider>(context);
    final List<UserVoucher> listVoucher = voucherProvide.listUserVoucher;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: const Text(
            'Chọn voucher',
            style: AppTextStyle.heading3Black,
          ),
        ),
        body: voucherProvide.isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(right: 7),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextFormField(
                                  // controller: txtBirtday,
                                  decoration: const InputDecoration(
                                      hintText: 'Nhập mã khuyến mãi',
                                      hintStyle: AppTextStyle.heading4Grey,
                                      border: InputBorder.none,
                                      errorStyle: AppTextStyle.heading4Grey),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 90,
                              decoration: const BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: TextButton(
                                child: const Text(
                                  'Áp dụng',
                                  style: AppTextStyle.heading4Grey,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Mã giảm giá',
                          style: AppTextStyle.heading3Black,
                        ),
                      ),
                      listVoucher.isEmpty
                          ? Padding(
                              padding:
                                  EdgeInsets.only(bottom: size.height / 1.7),
                              child: const Text(
                                'Bạn không có mã giảm giá nào.',
                                style: AppTextStyle.h_grey_no_underline,
                              ),
                            )
                          : SizedBox(
                              width: size.width,
                              height: size.height / 1.5,
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
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              decoration: const BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7))),
                                              child: const Center(
                                                  child: FaIcon(
                                                      FontAwesomeIcons.tags,
                                                      size: 60)),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                          fillColor: MaterialStateProperty.all(
                                              Colors.deepOrange),
                                          value:
                                              _selectedCheckboxIndex == index,
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
                      Container(
                        width: size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: TextButton(
                          child: const Text(
                            'Áp dụng',
                            style: AppTextStyle.heading3Light,
                          ),
                          onPressed: () {
                            voucherProvide.selectVoucher(
                                listVoucher[_selectedCheckboxIndex!]);
                            DateTime now = DateTime.now();
                            DateTime startAt = DateTime.parse(
                                voucherProvide.userVoucher.voucher.startAt);
                            DateTime endAt = DateTime.parse(
                                voucherProvide.userVoucher.voucher.endAt);
                            if (startAt.compareTo(now) == -1 &&
                                endAt.compareTo(now) == 1) {
                              Navigator.pop(context);
                            } else {
                              showMaterialDialog(context, '', 'Voucher quá hạn',
                                  () {
                                Navigator.pop(context);
                              });
                            }

                            // print(startAt.compareTo(now));
                            // print(endAt.compareTo(now));
                            // print(
                            //     DateTime.parse(userVoucher!.voucher!.startAt!) >
                            //         now);

                            // Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
