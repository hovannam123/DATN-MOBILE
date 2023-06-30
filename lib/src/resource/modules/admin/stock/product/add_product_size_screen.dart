import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/product_detail.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';
import 'package:safe_food/src/resource/provider/product_size_provider.dart';
import 'package:safe_food/src/resource/provider/size_provider.dart';
import 'package:safe_food/src/resource/utils/enums/helpers.dart';

import '../../../../model/size.dart';

class AddProductSizeScreen extends StatefulWidget {
  const AddProductSizeScreen({super.key, required this.productId});
  final int productId;

  @override
  State<AddProductSizeScreen> createState() => _AddProductSizeScreenState();
}

class _AddProductSizeScreenState extends State<AddProductSizeScreen> {
  Size? selectedSize;
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    Provider.of<ProductDetailProvider>(context, listen: false)
        .getProductDetail(widget.productId);
    Provider.of<SizeProvider>(context, listen: false).getListSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductDetailProvider>(context);
    final productDetail = productProvider.productDetail;
    final size = MediaQuery.of(context).size;
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');

    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFf5f5fa),
        ),
        child: productProvider.isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
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
                  title:
                      const Text("ADD SIZE", style: AppTextStyle.heading2Black),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.network(
                                    '${productDetail.imageOrigin}'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 260,
                                    child: Text(
                                      '${productDetail.name}',
                                      style: AppTextStyle.heading3Black,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    'Giá: ${decimalFormat.format(double.parse(productDetail.price!))}',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                  Text(
                                    'Tình trạng: ${productDetail.status! ? 'Còn hàng' : 'Hết hàng'}',
                                    style: AppTextStyle.heading3Black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Chọn size',
                                  style: AppTextStyle.heading3Black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  width: 120,
                                  padding: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Consumer<SizeProvider>(
                                      builder: (context, sizeProvider, _) {
                                    List<Size> sizes = sizeProvider.listSize;
                                    Size? defaultSize;

                                    if (selectedSize == null &&
                                        sizes.isNotEmpty) {
                                      defaultSize = sizes[0];
                                      selectedSize = defaultSize;
                                    }
                                    return DropdownButton<Size>(
                                      value: selectedSize,
                                      elevation: 16,
                                      icon: const Padding(
                                        padding: EdgeInsets.only(left: 45),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      style: AppTextStyle.heading4Grey,
                                      onChanged: (Size? newValue) {
                                        setState(() {
                                          selectedSize = newValue!;
                                        });
                                      },
                                      items: sizes.map<DropdownMenuItem<Size>>(
                                          (Size value) {
                                        return DropdownMenuItem<Size>(
                                          value: value,
                                          child: Text(value.sizeName!),
                                        );
                                      }).toList(),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Nhập số lượng',
                                  style: AppTextStyle.heading3Black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  width: 120,
                                  padding: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8)),
                                  child: TextField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Image.asset(
                                              'assets/images/btnCancel.png'),
                                          onPressed: () {
                                            amountController.clear();
                                          },
                                        ),
                                        hintText: 'Amount',
                                        hintStyle: AppTextStyle.heading4Grey,
                                        border: InputBorder.none,
                                        errorStyle: AppTextStyle.heading4Red),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 350,
                        ),
                        TextButton(
                            onPressed: () async {
                              print('object');
                              await Provider.of<ProductSizeProvider>(context,
                                      listen: false)
                                  .createProductSize(
                                      selectedSize!.id!,
                                      widget.productId,
                                      int.parse(amountController.text))
                                  .then((message) => {
                                        amountController.text = '',
                                        productProvider.getListProductDetail(),
                                        showSuccessDialog(context, message)
                                      });
                            },
                            child: Container(
                              height: 50,
                              width: size.width,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: AppTheme.analyse3),
                              child: const Center(
                                child: Text(
                                  'Add size',
                                  style: AppTextStyle.heading3Black,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ));
  }
}
