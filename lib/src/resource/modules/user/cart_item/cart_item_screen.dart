import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';

import 'package:safe_food/src/resource/model/cart_item.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/modules/user/home_page/home_page.dart';
import 'package:safe_food/src/resource/repositories/payment_repo.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../provider/cart_item_provider.dart';

class CartItemScreen extends StatefulWidget {
  const CartItemScreen({super.key});

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  @override
  void initState() {
    Provider.of<CartItemProvider>(context, listen: false).getListCartItem();
    super.initState();
  }

  void reloadUI() {
    setState(() {
      Provider.of<CartItemProvider>(context, listen: false).getListCartItem();
    });
  }

  Future<void> _launchURL(String _url) async {
    await launchUrl(Uri.parse(_url)).then((resultingValue) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  totalItem(List<CartItem> list) {
    double total = 0;
    list.forEach((item) {
      total += double.parse(item.total!);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final cartProvider = Provider.of<CartItemProvider>(context);
    final List<CartItem> cartItem = cartProvider.listCartItem;
    final PaymentRepository _paymentRepository = PaymentRepository();
    final size = MediaQuery.of(context).size;
    return Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: cartProvider.isLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Column(
                    children: [
                      cartItem.isEmpty
                          ? Padding(
                              padding:
                                  EdgeInsets.only(bottom: size.height / 1.6),
                              child: const Text(
                                'Giỏ hàng trống.',
                                style: AppTextStyle.h_grey_no_underline,
                              ),
                            )
                          : Expanded(
                              child: SizedBox(
                                  child: ListView.builder(
                              itemCount: cartItem.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      border: Border.all(
                                          color: Colors.white54,
                                          style: BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    '${cartItem[index].product!.imageOrigin}',
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 220,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  '${cartItem[index].product!.name}',
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                decimalFormat.format(
                                                    double.parse(cartItem[index]
                                                        .total!)),
                                                style:
                                                    AppTextStyle.heading4Black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      await cartProvider
                                                          .increaseQuantity(
                                                              cartItem[index]
                                                                  .id!)
                                                          .then((message) =>
                                                              showSnackbar(
                                                                  context,
                                                                  message));

                                                      reloadUI();
                                                    },
                                                    icon: const FaIcon(
                                                        FontAwesomeIcons
                                                            .circlePlus)),
                                                Text(
                                                    '${cartItem[index].quantity}'),
                                                IconButton(
                                                  onPressed: () async {
                                                    await cartProvider
                                                        .decreaseQuantity(
                                                            cartItem[index].id!)
                                                        .then((message) =>
                                                            showSnackbar(
                                                                context,
                                                                message));
                                                    reloadUI();
                                                  },
                                                  icon: const FaIcon(
                                                      FontAwesomeIcons
                                                          .circleMinus),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.color2,
                                                  border: Border.all(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              child: Center(
                                                child: Text(
                                                  '${cartItem[index].size!.sizeName}',
                                                  style: AppTextStyle
                                                      .h_grey_no_underline,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                print(cartItem[index].id!);
                                                await cartProvider
                                                    .deleteCartItem(
                                                        cartItem[index].id!)
                                                    .then((message) =>
                                                        showSnackbar(
                                                            context, message));

                                                reloadUI();
                                              },
                                              icon: const FaIcon(
                                                  FontAwesomeIcons.trashCan),
                                            )
                                          ],
                                        )
                                      ]),
                                );
                              },
                            ))),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.only(top: 30),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.black38, width: 1))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tổng cộng',
                                  style: AppTextStyle.h_grey_no_underline,
                                ),
                                Text(
                                  decimalFormat.format(totalItem(cartItem)),
                                  style: AppTextStyle.heading3Black,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Giảm giá',
                                  style: AppTextStyle.h_grey_no_underline,
                                ),
                                Text(
                                  '100',
                                  style: AppTextStyle.heading3Black,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Thành tiền',
                                  style: AppTextStyle.h_grey_no_underline,
                                ),
                                Text(
                                  decimalFormat.format(totalItem(cartItem)),
                                  style: AppTextStyle.heading3Black,
                                )
                              ],
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 20),
                                width: size.width,
                                height: 44,
                                decoration: const BoxDecoration(
                                    color: AppTheme.color2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  onPressed: () async {
                                    User? user =
                                        await StoreData().retrieveUser();
                                    await _paymentRepository
                                        .createPayment(user.id!)
                                        .then((url) => {_launchURL(url)});
                                  },
                                  child: const Text(
                                    'Thanh toán',
                                    style: AppTextStyle.heading3Light,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
