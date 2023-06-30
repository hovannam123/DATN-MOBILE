import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_food/src/resource/model/cart_item.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/model/user_voucher.dart';
import 'package:safe_food/src/resource/model/voucher.dart';
import 'package:safe_food/src/resource/modules/user/forget_password/forget_password.dart';
import 'package:safe_food/src/resource/modules/user/home_page/home_page.dart';
import 'package:safe_food/src/resource/modules/user/voucher/voucher_screen.dart';
import 'package:safe_food/src/resource/provider/user_provider.dart';
import 'package:safe_food/src/resource/provider/voucher_provider.dart';
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

  getVoucherPrice() {
    final voucherProvider = Provider.of<VoucherProvider>(context);
    UserVoucher? userVoucher = voucherProvider.userVoucher;
    return userVoucher == null ? 0 : userVoucher.voucher!.valuePercent;
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    final cartProvider = Provider.of<CartItemProvider>(context);
    final List<CartItem> cartItem = cartProvider.listCartItem;

    final PaymentRepository _paymentRepository = PaymentRepository();
    final size = MediaQuery.of(context).size;
    final voucherProvider = Provider.of<VoucherProvider>(context);
    UserVoucher? userVoucher = voucherProvider.userVoucher;

    return Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: cartProvider.isLoad
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: size.height - 80,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Column(
                      children: [
                        cartItem.isEmpty
                            ? Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.height / 1.9),
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
                                                width: 190,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                      double.parse(
                                                          cartItem[index]
                                                              .total!)),
                                                  style: AppTextStyle
                                                      .heading4Black,
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
                                                                    .id!
                                                                    .toInt())
                                                            .then((message) =>
                                                                showSuccessDialog(
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
                                                              cartItem[index]
                                                                  .id!)
                                                          .then((message) =>
                                                              showSuccessDialog(
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
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
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
                                                          showSuccessDialog(
                                                              context,
                                                              message));

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
                        SizedBox(
                          width: size.width,
                          // padding: EdgeInsets.only(top: 30),

                          child: Column(
                            children: [
                              Container(
                                width: size.width,
                                height: 50,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.black38, width: 1),
                                        right: BorderSide(
                                            color: Colors.black38, width: 1),
                                        left: BorderSide(
                                            color: Colors.black38, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black38, width: 1))),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VoucherScreen()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: const [
                                            FaIcon(
                                              FontAwesomeIcons.tags,
                                              color: Colors.black54,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Voucher của bạn',
                                                style:
                                                    AppTextStyle.heading4Black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              userVoucher != null
                                                  ? 'Giảm ${(userVoucher.voucher!.valuePercent!.toDouble() * 100).toInt()}%'
                                                  : 'Chọn hoặc nhập mã',
                                              style: const TextStyle(
                                                  height: 1.2,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins-Light',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            userVoucher == null
                                                ? const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.black54,
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      voucherProvider
                                                          .unselectVoucher();
                                                    },
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons.xmark,
                                                      color: Colors.black54,
                                                      size: 15,
                                                    ))
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Giảm giá',
                                    style: AppTextStyle.h_grey_no_underline,
                                  ),
                                  Text(
                                    decimalFormat.format(getVoucherPrice() *
                                        totalItem(cartItem)),
                                    style: AppTextStyle.heading3Black,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Thành tiền',
                                    style: AppTextStyle.h_grey_no_underline,
                                  ),
                                  Text(
                                    decimalFormat.format(totalItem(cartItem) -
                                        totalItem(cartItem) *
                                            getVoucherPrice()),
                                    style: AppTextStyle.heading3Black,
                                  )
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, bottom: 20),
                                  width: size.width,
                                  height: 44,
                                  decoration: const BoxDecoration(
                                      color: AppTheme.color2,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (user!.active!) {
                                        if (userVoucher?.voucher != null) {
                                          await _paymentRepository
                                              .createPayment(
                                                  userVoucher:
                                                      userVoucher!.voucher!.id)
                                              .then((url) => {
                                                    voucherProvider
                                                        .unselectVoucher(),
                                                    _launchURL(url)
                                                  });
                                        } else {
                                          await _paymentRepository
                                              .createPayment()
                                              .then((url) => {_launchURL(url)});
                                        }
                                      } else {
                                        showMaterialDialog(
                                            context,
                                            'Tài khoản chưa được xác thực',
                                            'Bạn có muốn xác thực ?', () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SendEmail(
                                                          isResetPW: false)));
                                        });
                                      }
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
          ),
        ));
  }
}
