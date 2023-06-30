import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/bill_item.dart';
import 'package:safe_food/src/resource/modules/user/product_detail/product_detail_screen.dart';
import 'package:safe_food/src/resource/provider/bill_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class UserBillScreen extends StatefulWidget {
  const UserBillScreen({super.key});

  @override
  State<UserBillScreen> createState() => _UserBillScreenState();
}

class _UserBillScreenState extends State<UserBillScreen> {
  @override
  Widget build(BuildContext context) {
    final billProvider = Provider.of<BillProvider>(context);

    final List<BillItem> listBillItem = billProvider.listBillItem;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final size = MediaQuery.of(context).size;
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 240, 242, 247),
        ),
        child: billProvider.isLoad
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
                  title: Row(
                    children: [
                      const Text("Bill item",
                          style: AppTextStyle.heading2Black),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 50,
                        height: 25,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                            child: Text(
                          '${listBillItem.length}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                          width: size.width,
                          height: size.height - 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: listBillItem.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: size.width,
                                height: 250,
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 45,
                                      decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Tình trạng: ${listBillItem[index].status}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontFamily: 'Poppins-Light',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yy').format(
                                                listBillItem[index].createdAt!),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Text('Tổng cộng',
                                                  style: AppTextStyle
                                                      .heading3Black),
                                              const SizedBox(
                                                width: 120,
                                              ),
                                              Text(
                                                decimalFormat.format(
                                                    double.parse(
                                                        listBillItem[index]
                                                            .totalOrigin!)),
                                                style:
                                                    AppTextStyle.heading3Black,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Text('Giảm giá',
                                                  style: AppTextStyle
                                                      .heading3Black),
                                              const SizedBox(
                                                width: 120,
                                              ),
                                              Text(
                                                  decimalFormat.format(
                                                      double.parse(
                                                          listBillItem[index]
                                                              .totalVoucher!)),
                                                  style: AppTextStyle
                                                      .heading3Black)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Text(
                                                'Thành tiền',
                                                style:
                                                    AppTextStyle.heading3Black,
                                              ),
                                              const SizedBox(
                                                width: 120,
                                              ),
                                              Text(
                                                decimalFormat.format(
                                                    double.parse(
                                                        listBillItem[index]
                                                            .totalPayment!)),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: size.width - 50,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: listBillItem[index]
                                              .billItems!
                                              .length,
                                          itemBuilder: (context, index2) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3, top: 3),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      '${listBillItem[index].billItems![index2].quantity} x ',
                                                      style: AppTextStyle
                                                          .heading3Black),
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 3, right: 3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    15)),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            '${listBillItem[index].billItems![index2].product!.imageOrigin}',
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: size.width - 160,
                                                    child: Text(
                                                        '${listBillItem[index].billItems![index2].product!.name}',
                                                        style: AppTextStyle
                                                            .heading3Black,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    (50)))),
                                                    child: Center(
                                                      child: Text(
                                                        '${listBillItem[index].billItems![index2].size!.sizeName}',
                                                        style: AppTextStyle
                                                            .heading3Black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )))));
  }
}
