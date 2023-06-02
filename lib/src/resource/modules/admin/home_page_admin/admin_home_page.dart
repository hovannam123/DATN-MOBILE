import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/bill.dart';
import 'package:safe_food/src/resource/model/bill_count.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/modules/admin/charts/MyCharts.dart';
import 'package:safe_food/src/resource/provider/bill_item_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';

import '../../../../../config/app_color.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    Provider.of<BillProvider>(context, listen: false).getListBill();
    Provider.of<BillProvider>(context, listen: false).getListBillPending();
    Provider.of<ProductProvider>(context, listen: false).getListProduct();
    Provider.of<UserProvider>(context, listen: false).getListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');

    final billProvider = Provider.of<BillProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    final List<Bill> listBill = billProvider.listBill;
    final List<Bill> listBillPending = billProvider.listBillPending;

    final List<Product> listProduct = productProvider.listProduct;
    final List<User> listUser = userProvider.listUser;

    double getSales() {
      double total = 0;
      listBill.forEach((item) {
        total += double.parse(item.totalPayment.toString());
      });
      return total;
    }

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: billProvider.isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.gripVertical,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
                actions: [
                  Text(
                    'Jack',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width / 2 - 20,
                          height: size.width / 2 - 20,
                          decoration: const BoxDecoration(
                              color: AppTheme.analyse1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.chartSimple,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  decimalFormat.format(getSales()),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'All sales',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      height: 1.4,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Tap to view',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width / 2 - 20,
                          height: size.width / 2 - 20,
                          decoration: const BoxDecoration(
                              color: AppTheme.analyse2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.listCheck,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${listBillPending.length}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Pending Order',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      height: 1.4,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Tap to view',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width / 2 - 20,
                          height: size.width / 2 - 20,
                          decoration: const BoxDecoration(
                              color: AppTheme.analyse3,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.warehouse,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${listProduct.length}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Stock Avaiable',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      height: 1.4,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Tap to view',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width / 2 - 20,
                          height: size.width / 2 - 20,
                          decoration: const BoxDecoration(
                              color: AppTheme.analyse4,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.users,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${listUser.length}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'All Customer',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      height: 1.4,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Tap to view',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Order Overview',
                      style: AppTextStyle.heading1SemiBold,
                    ),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: LineChartSample2(),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
