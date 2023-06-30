import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/modules/user/product_detail/product_detail_screen.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({super.key});

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final productProvider = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    List<Product> products = productProvider.listProductByCategory;
    return productProvider.isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : products.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  'Không có sản phẩm',
                  style: AppTextStyle.heading3Black,
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: size.width,
                height: size.height / 1.7,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 180,
                            childAspectRatio: 2 / 3.7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10),
                    itemCount: products.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<ProductDetailProvider>(context,
                                  listen: false)
                              .getProductDetail(products[index].id!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                        productId: products[index].id,
                                      )));
                        },
                        child: Container(
                          width: size.width / 2 - 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white54,
                              border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width - 180,
                                height: size.height / 4,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${products[index].imageOrigin}'),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  '${products[index].name}',
                                  style: AppTextStyle.heading3Black,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      decimalFormat.format(
                                          double.parse(products[index].price!)),
                                      style: AppTextStyle.h_grey_no_underline,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.circlePlus,
                                          color: Colors.pink.shade200,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
  }
}
