import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/modules/admin/user_bill/user_bill_screen.dart';
import 'package:safe_food/src/resource/modules/admin/voucher/user_voucher_screen.dart';
import 'package:safe_food/src/resource/provider/bill_provider.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final userProvider = Provider.of<UserProvider>(context);
    final List<User> listUser = userProvider.listUser;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 242, 247),
      ),
      child: Scaffold(
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
              const Text("USER ANALYTICS", style: AppTextStyle.heading2Black),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 50,
                height: 25,
                decoration: const BoxDecoration(
                    color: AppTheme.analyse4,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Center(
                    child: Text(
                  '${listUser.length}',
                  style: const TextStyle(
                      color: AppTheme.analyse3,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height - 100,
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 9),
            child: ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                return Container(
                  width: size.width,
                  height: 230,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black54, width: 0.8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(listUser[index]
                                              .userInformation
                                              ?.userImage ??
                                          'https://cdn-icons-png.flaticon.com/512/2815/2815428.png'))),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      listUser[index]
                                              .userInformation
                                              ?.firstName ??
                                          " ",
                                      style: AppTextStyle.heading2Black,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      listUser[index]
                                              .userInformation
                                              ?.lastName ??
                                          " ",
                                      style: AppTextStyle.heading2Black,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.width / 2 - 10,
                                  child: Text(
                                    '${listUser[index].email}',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.heading3Black,
                                  ),
                                ),
                                Text(
                                  listUser[index]
                                          .userInformation
                                          ?.birthday
                                          ?.split("T")[0] ??
                                      " ",
                                  style: AppTextStyle.heading3Black,
                                ),
                                Text(
                                  listUser[index].phoneNumber ?? " ",
                                  style: AppTextStyle.heading3Black,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Total bill',
                            style: AppTextStyle.heading3Black,
                          ),
                          Text(
                            '${listUser[index].billData![0].totalBill}',
                            style: AppTextStyle.heading3Black,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Total payment',
                            style: AppTextStyle.heading3Black,
                          ),
                          Text(
                            decimalFormat.format(double.parse(
                                listUser[index].billData![0].totalPayment!)),
                            style: AppTextStyle.heading3Black,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Provider.of<BillProvider>(context, listen: false)
                                  .getListBillItemUserInAd(listUser[index].id!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserBillScreen()));
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Center(
                                child: Text(
                                  'Bill detail',
                                  style: AppTextStyle.heading3Black,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserVoucherScreen(
                                            userId: listUser[index].id)));
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    'Voucher',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
