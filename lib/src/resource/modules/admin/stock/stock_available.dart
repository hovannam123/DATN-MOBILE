import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/product_detail_model.dart';
import 'package:safe_food/src/resource/modules/admin/all_size/size_screen.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';

import '../../../../../config/app_color.dart';

class StockAvailable extends StatefulWidget {
  const StockAvailable({super.key});

  @override
  State<StockAvailable> createState() => _StockAvailableState();
}

class _StockAvailableState extends State<StockAvailable> {
  @override
  void initState() {
    Provider.of<ProductDetailProvider>(context, listen: false)
        .getListProductDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prodDetailProvider = Provider.of<ProductDetailProvider>(context);
    final List<ProductDetailModel> listProduct = prodDetailProvider.listProduct;
    final size = MediaQuery.of(context).size;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');

    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFf5f5fa),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFf5f5fa),
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
                const Text("STOCK ANALYTICS",
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
                    '${listProduct.length}',
                    style: const TextStyle(
                        color: AppTheme.analyse3,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
          ),
          body: prodDetailProvider.isLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: const BoxDecoration(
                              gradient: AppTheme.gradient_analyse3,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: TextButton(
                              child: const Text(
                                'Add Product',
                                style: AppTextStyle.heading3Light,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width / 2 - 15,
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: const BoxDecoration(
                                  gradient: AppTheme.gradient_analyse2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextButton(
                                  child: const Text(
                                    'All Size',
                                    style: AppTextStyle.heading3Light,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SizeScreen()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: size.width / 2 - 15,
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: const BoxDecoration(
                                  gradient: AppTheme.gradient_analyse1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextButton(
                                  child: const Text(
                                    'All Category',
                                    style: AppTextStyle.heading3Light,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Available Product List',
                          style: TextStyle(
                              fontFamily: 'Poppins-Bold', fontSize: 18),
                        ),
                        SizedBox(
                            width: size.width,
                            height: size.height,
                            child: ListView.builder(
                              itemCount: listProduct.length,
                              itemBuilder: (context, index) {
                                return listProduct[index].status == true
                                    ? Container(
                                        width: size.width,
                                        height: 200,
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.5))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 75,
                                                    height: 75,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              '${listProduct[index].imageOrigin}')),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width - 100,
                                                        child: Text(
                                                          '${listProduct[index].name}',
                                                          style: AppTextStyle
                                                              .heading3Black,
                                                        ),
                                                      ),
                                                      Text(
                                                        decimalFormat.format(
                                                            double.parse(
                                                                listProduct[
                                                                        index]
                                                                    .price!)),
                                                        style: AppTextStyle
                                                            .h_grey_no_underline,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Available',
                                                style: AppTextStyle
                                                    .h_grey_no_underline,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  width: size.width - 70,
                                                  height: 70,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: ListView.builder(
                                                    itemCount:
                                                        listProduct[index]
                                                            .sizeData!
                                                            .length,
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            listProduct[index]
                                                                .sizeData![
                                                                    index2]
                                                                .size!
                                                                .sizeName!,
                                                            style: AppTextStyle
                                                                .h_grey_no_underline,
                                                          ),
                                                          Text(
                                                            listProduct[index]
                                                                .sizeData![
                                                                    index2]
                                                                .amount!
                                                                .toString(),
                                                            style: AppTextStyle
                                                                .h_grey_no_underline,
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  )),
                                            )
                                          ],
                                        ),
                                      )
                                    : null;
                              },
                            ))
                      ],
                    ),
                  ),
                ),
        ));
  }
}
