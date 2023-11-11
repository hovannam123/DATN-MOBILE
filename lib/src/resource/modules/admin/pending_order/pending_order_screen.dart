import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/bill_item.dart';
import 'package:safe_food/src/resource/provider/bill_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

class BillItemScreen extends StatefulWidget {
  const BillItemScreen({super.key});

  @override
  State<BillItemScreen> createState() => _BillItemScreenState();
}

class _BillItemScreenState extends State<BillItemScreen> {
  @override
  void initState() {
    Provider.of<BillProvider>(context, listen: false).getListBillItemPending();
    super.initState();
  }

  void reloadUI() {
    setState(() {
      Provider.of<BillProvider>(context, listen: false)
          .getListBillItemPending();
    });
  }

  @override
  Widget build(BuildContext context) {
    final billProvider = Provider.of<BillProvider>(context);

    final List<BillItem> listBillItem = billProvider.listBillItem;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final size = MediaQuery.of(context).size;
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFf5f5fa),
        ),
        child: billProvider.isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xFFf5f5fa),
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
                      const Text("PENDING ORDER LIST",
                          style: AppTextStyle.heading2Black),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Center(
                            child: Text(
                          '${listBillItem.length}',
                          style: TextStyle(
                              color: Colors.pink.shade200,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.pink.shade200,
                    onPressed: () async {
                      await billProvider.verifyAllOrder().then((message) => {
                            billProvider.getListBillPending,
                            showSuccessDialog(context, message)
                          });
                      reloadUI();
                    },
                    label: const Text(
                      "Verify All",
                      style: AppTextStyle.heading3Black,
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
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
                                      decoration: BoxDecoration(
                                          color: Colors.pink.shade200,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    listBillItem[index]
                                                            .user
                                                            ?.userInformation
                                                            ?.userImage ??
                                                        'https://cdn-icons-png.flaticon.com/512/2815/2815428.png',
                                                  ),
                                                )),
                                          ),
                                          Text(
                                            '${listBillItem[index].user!.email}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yy').format(
                                                listBillItem[index].createdAt!),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 120,
                                          ),
                                          Text(
                                            decimalFormat.format(double.parse(
                                                listBillItem[index]
                                                    .totalPayment!)),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
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
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .pink.shade200,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
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
                                    TextButton(
                                        onPressed: () async {
                                          await billProvider
                                              .verifyOrder(
                                                  listBillItem[index].id!)
                                              .then((message) => {
                                                    billProvider
                                                        .getListBillPending,
                                                    showSuccessDialog(
                                                        context, message)
                                                  });
                                          reloadUI();
                                        },
                                        child: Container(
                                          width: size.width / 3.4,
                                          height: 27,
                                          decoration: BoxDecoration(
                                              color: Colors.pink.shade200,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15))),
                                          child: const Center(
                                            child: Text(
                                              "Verify",
                                              style: AppTextStyle.heading3Black,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        )))));
  }
}
