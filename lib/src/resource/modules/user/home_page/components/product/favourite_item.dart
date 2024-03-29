import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:safe_food/src/resource/model/top_product_favourite.dart';
import 'package:safe_food/src/resource/modules/user/product_detail/product_detail_screen.dart';
import 'package:safe_food/src/resource/provider/category_provider.dart';
import 'package:safe_food/src/resource/provider/product_detail_provider.dart';
import 'package:safe_food/src/resource/provider/product_provider.dart';

class TopFavouriteItem extends StatefulWidget {
  const TopFavouriteItem({super.key});

  @override
  State<TopFavouriteItem> createState() => _TopFavouriteItemState();
}

class _TopFavouriteItemState extends State<TopFavouriteItem> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getListTopFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat decimalFormat =
        NumberFormat.simpleCurrency(locale: 'vi-VN');
    final productProvider = Provider.of<ProductProvider>(context);
    final List<TopProductFavourite> topProduct =
        productProvider.listTopFavourite;
    final size = MediaQuery.of(context).size;
    final index = Provider.of<CategoryProvider>(context).selectedIndex;

    return index == 0
        ? Container(
            margin: const EdgeInsets.only(top: 20, left: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Sản phẩm được yêu thích',
                  style: AppTextStyle.heading2Black,
                ),
              ),
              SizedBox(
                height: size.height / 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topProduct.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<ProductDetailProvider>(context,
                                listen: false)
                            .getProductDetail(topProduct[index].product!.id!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                    productId: topProduct[index].product!.id)));
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: size.width - 180,
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
                                  height: size.height / 3.2,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${topProduct[index].product!.imageOrigin}'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  child: Text(
                                    '${topProduct[index].product!.name}',
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
                                        decimalFormat.format(double.parse(
                                            topProduct[index].product!.price!)),
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
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(17),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.pink.shade200,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${topProduct[index].totalFavourite}',
                                      style: TextStyle(
                                          color: Colors.pink.shade200,
                                          fontFamily: 'Poppins-Light',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                ),
              )
            ]),
          )
        : Container();
  }
}
